#!/usr/bin/env -S deno run -A

import { concat } from "jsr:@std/bytes@1.0.5/concat";
import { parseArgs } from "jsr:@std/cli@1.0.13/parse-args";
import { $ } from "jsr:@david/dax@0.45.0";
import symlinksJSON from "./symlinks.json" with { "type": "json" };
import path from "node:path";

const encoder = new TextEncoder();
const gray = encoder.encode("\x1b[90m");
const red = encoder.encode("\x1b[31m");
const reset = encoder.encode("\x1b[0m");
const coloredWriter = (color: Uint8Array) =>
  new WritableStream({
    write(chunk) {
      Deno.stdout.writeSync(concat([color, chunk, reset]));
    },
  });

if (import.meta.main) {
  const args = parseArgs(Deno.args, {
    boolean: ["sudo", "install-fonts"],
  });
  const canUseSudo = args["sudo"];
  const canInstallFonts = args["install-fonts"];

  $.setPrintCommand(true);

  const home = $.path(Deno.env.get("HOME") || Deno.env.get("USERPROFILE")!);
  home.join(".config").mkdirSync({ recursive: true });

  const root = $.path(Deno.cwd());
  const backupDir = root.join(".backup", `${Date.now()}`);
  backupDir.join(".gitignore").writeTextSync("*");

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

  for (const [_target, _source] of Object.entries(symlinks)) {
    const source = path.isAbsolute(_source)
      ? path.resolve(_source)
      : path.resolve(root.toString(), _source);
    const target = $.path(_target.replace(/^~\//, `${home}/`));
    const needsSudo = !target.startsWith(home);
    if (!canUseSudo && needsSudo) {
      $.log(`Symlink skipped (${_source} -> ${_target})`);
      continue;
    }

    if (target.existsSync()) {
      if (target.isSymlinkSync()) {
        needsSudo ? await $`sudo unlink ${target}` : await $`unlink ${target}`;
      } else {
        needsSudo
          ? await $`sudo mv ${target} ${backupDir}`
          : await $`mv ${target} ${backupDir}`;
      }
    }

    const parent = target.parent();
    if (parent && !parent.existsSync()) {
      needsSudo
        ? await $`sudo mkdir -p ${parent}`
        : await $`mkdir -p ${parent}`;
    }

    // NOTE: expand source automatically
    needsSudo
      ? await $`sudo ln -sfn "${$.rawArg(source)}" ${target}`
      : await $`ln -sfn "${$.rawArg(source)}" ${target}`;
  }

  const packageManagerTask = ({
    "linux": "apt",
    "darwin": "brew",
    "windows": "winget",
  } as Record<string, string>)[Deno.build.os];
  const tasks = [
    ...canUseSudo && packageManagerTask ? [packageManagerTask] : [],
    "mise",
    ...canInstallFonts ? ["font"] : [],
  ];

  $.log(`Tasks ${tasks} will be executed`);

  for (const task of tasks) {
    $.log(`Task: ${task}`);
    const script = root.join(`_setup/${task}.sh`);
    await $`bash ${script}`
      .stdout(coloredWriter(gray))
      .stderr(coloredWriter(red));
  }
}
