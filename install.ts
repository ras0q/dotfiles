#!/usr/bin/env -S deno run -A

import { parseArgs } from "jsr:@std/cli@1.0.13/parse-args";
import { $, Path } from "jsr:@david/dax@0.42.0";
import symlinksJSON from "./symlinks.json" with { "type": "json" };

$.setPrintCommand(true);

const home = $.path(Deno.env.get("HOME") || Deno.env.get("USERPROFILE")!);
home.join(".config").mkdirSync({ recursive: true });

const root = $.path(Deno.cwd());
const backupDir = root.join(".backup", `${Date.now()}`);
backupDir.join(".gitignore").writeTextSync("*");

if (import.meta.main) {
  // TODO: remove this
  Deno.env.set("__STEP__", "echo");

  const args = parseArgs(Deno.args, {
    boolean: ["sudo", "install-fonts"],
  });
  const canUseSudo = args["sudo"];
  const canInstallFonts = args["install-fonts"];

  const { os } = Deno.build;
  const isLinux = os === "linux";
  const isWSL2 = isLinux && Deno.env.get("WSL_DISTRO_NAME") !== undefined;
  const isMac = os === "darwin";
  const isWindows = os === "windows";

  const symlinks = {
    ...symlinksJSON._common,
    ...isWSL2 ? symlinksJSON.wsl2 : {},
    ...isMac ? symlinksJSON.darwin : {},
    ...isWindows ? symlinksJSON.windows : {},
  };

  await Promise.all(
    Object.entries(symlinks).map(([target, source]) => {
      const sourcePath = root.join(source);
      const targetPath = $.path(target.replace(/^~\//, `${home}/`));
      return createSymlink(sourcePath, targetPath, backupDir, canUseSudo);
    }),
  );

  const tasks = [
    ...canUseSudo
      ? [
        ...isLinux ? ["apt"] : [],
        ...isMac ? ["brew"] : [],
        ...isWindows ? ["winget"] : [],
      ]
      : [],
    "mise",
    ...canInstallFonts ? ["font"] : [],
  ].map((task) => root.join(`_setup/${task}.sh`));

  for (const task of tasks) {
    await runShellScript(task);
  }
}

async function createSymlink(
  source: Path,
  target: Path,
  backupDir: Path,
  canUseSudo: boolean,
) {
  if (!source.existsSync()) throw `${source} not exist`;

  const needsSudo = !target.startsWith(home);
  if (!canUseSudo && needsSudo) {
    $.log(`Symlink skipped (${source} -> ${target})`);
    return;
  }

  if (target.existsSync()) {
    needsSudo
      ? await $`sudo mv ${target} ${backupDir}`
      : await $`mv ${target} ${backupDir}`;
  }

  needsSudo
    ? await $`sudo ln -sfn ${source} ${target}`
    : await $`ln -sfn ${source} ${target}`;
}

async function runShellScript(path: Path) {
  const encoder = new TextEncoder();
  const gray = encoder.encode("\x1b[90m");
  const red = encoder.encode("\x1b[31m");
  const reset = encoder.encode("\x1b[0m");
  await $`bash ${path}`
    .stdout(
      new WritableStream({
        write(chunk) {
          Deno.stdout.writeSync(gray);
          Deno.stdout.writeSync(chunk);
          Deno.stdout.writeSync(reset);
        },
      }),
    )
    .stderr(
      new WritableStream({
        write(chunk) {
          Deno.stdout.writeSync(red);
          Deno.stdout.writeSync(chunk);
          Deno.stdout.writeSync(reset);
        },
      }),
    );
}
