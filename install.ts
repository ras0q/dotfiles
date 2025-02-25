#!/usr/bin/env -S deno run -A

import { parseArgs } from "jsr:@std/cli@1.0.13/parse-args";
import { $, Path } from "jsr:@david/dax@0.42.0";

$.setPrintCommand(true);

const args = parseArgs(Deno.args, {
  boolean: ["sudo", "install-fonts"],
});

// TODO: remove this
Deno.env.set("__STEP__", "echo");

const home = $.path(Deno.env.get("HOME")!);
home.join(".config").mkdirSync();

// const root = $.path(await $`git rev-parse --show-toplevel`.text());
const root = $.path(Deno.cwd());
const backupDir = root.join(".backup", new Date().toISOString());
const logsDir = backupDir.join("logs");
logsDir.mkdirSync({ recursive: true });
backupDir.join(".gitignore").writeTextSync("*");

async function createSymlink(
  source: Path,
  target: Path,
  useSudo: boolean = false,
) {
  if (!source.existsSync()) throw `${source} not exist`;

  if (!args["sudo"] && useSudo) {
    $.log(`Symlink skipped (${source} -> ${target})`);
    return;
  }

  if (target.existsSync()) {
    // useSudo
    //  ? await $`sudo mv ${target} ${backupDir}`
    //  : await $`mv ${target} ${backupDir}`;
  }

  useSudo
    ? await $`sudo ln -sfn ${source} ${target}`
    : await $`ln -sfn ${source} ${target}`;
}

const encoder = new TextEncoder();
const gray = encoder.encode("\x1b[90m");
const red = encoder.encode("\x1b[31m");
const reset = encoder.encode("\x1b[0m");
async function runSetup(name: string) {
  const setupPath = root.join("_setup", `${name}.sh`);
  if (!setupPath.existsSync()) throw `${setupPath} not exist`;

  await $`bash ${setupPath}`
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

const symlinks = [
  ...[".bash_profile", ".bashrc", ".gitconfig", ".gittemplate.txt"].map(
    (f) => [root.join("common", f), home.join(f)],
  ),
  ...["fish", "mise", "starship.toml", "zellij"].map(
    (f) => [root.join("common", f), home.join(".config", f)],
  ),
];
switch (Deno.build.os) {
  case "linux": {
    symlinks.push([
      root.join("common", "helix"),
      home.join(".config", "helix"),
    ]);

    for (const [source, target] of symlinks) {
      await createSymlink(source, target);
    }

    const isWSL2 = Deno.env.get("WSL_DISTRO_NAME") !== undefined;
    isWSL2 &&
      await createSymlink(
        root.join("win", "wsl.conf"),
        $.path("/etc").join("wsl.conf"),
        true,
      );

    args["sudo"] && await runSetup("apt");
    await runSetup("mise");
    args["install-fonts"] && await runSetup("font");

    break;
  }

  case "darwin": {
    symlinks.push(
      [root.join("common", "helix"), home.join(".config", "helix")],
      ...[".Brewfile", ".Brewfile.lock.json", ".gitconfig.mac"].map(
        (f) => [root.join("mac", f), home.join(f)],
      ),
      ...["skhd", "yabai"].map(
        (f) => [root.join("mac", f), home.join(".config", f)],
      ),
      [root.join("mac", "warp"), home.join(".warp")],
    );

    for (const [source, target] of symlinks) {
      await createSymlink(source, target);
    }

    args["sudo"] && await runSetup("brew");
    await runSetup("mise");
    args["install-fonts"] && await runSetup("font");

    break;
  }

  case "windows": {
    symlinks.push(
      [root.join("win", ".wslconfig"), home.join(".wslconfig")],
      [
        root.join("win", "terminal/settings.json"),
        home.join(
          "AppData",
          "Local",
          "Packages",
          "Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe",
          "LocalState",
          "settings.json",
        ),
      ],
      [root.join("common", "helix"), home.join("AppData", "Roaming", "helix")],
      [
        root.join("win", "Microsoft.PowerShell_profile.ps1"),
        home.join(
          "Documents",
          "PowerShell",
          "Microsoft.PowerShell_profile.ps1",
        ),
      ],
      [
        root.join("win", "Microsoft.PowerShell_profile.ps1"),
        home.join(
          "Documents",
          "PowerShell",
          "Microsoft.VSCode_profile.ps1",
        ),
      ],
    );

    for (const [source, target] of symlinks) {
      createSymlink(source, target);
    }

    await runSetup("winget");
    args["install-fonts"] && await runSetup("font");

    break;
  }

  default: {
    throw `Unsupported OS: ${Deno.build.os}`;
  }
}
