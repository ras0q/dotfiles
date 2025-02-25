#!/usr/bin/env -S deno run -A

import { parseArgs } from "jsr:@std/cli@1.0.13/parse-args";
import { $, Path } from "jsr:@david/dax@0.42.0";

$.setPrintCommand(true);

const args = parseArgs(Deno.args, {
  boolean: ["sudo", "install-fonts"],
});

// TODO: remove this
Deno.env.set("__STEP__", "echo");

const homeDir = $.path(Deno.env.get("HOME")!);
const configDir = homeDir.join(".config");
configDir.mkdirSync();

// const rootDir = $.path(await $`git rev-parse --show-toplevel`.text());
const rootDir = $.path(Deno.cwd());
const setupDir = rootDir.join("_setup");
const commonDir = rootDir.join("common");
const macDir = rootDir.join("mac");
const winDir = rootDir.join("win");
const backupDir = rootDir.join(".backup", new Date().toISOString());
const logsDir = backupDir.join("logs");
logsDir.mkdirSync({ recursive: true });
backupDir.join(".gitignore").writeTextSync("*");

async function createSymlink(
  source: Path,
  target: Path,
  useSudo: boolean = false,
) {
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
  const setupPath = setupDir.join(`${name}.sh`);
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
    (f) => [commonDir.join(f), homeDir.join(f)],
  ),
  ...["fish", "mise", "starship.toml", "zellij"].map(
    (f) => [commonDir.join(f), configDir.join(f)],
  ),
];
switch (Deno.build.os) {
  case "linux": {
    symlinks.push([commonDir.join("helix"), configDir.join("helix")]);

    for (const [source, target] of symlinks) {
      await createSymlink(source, target);
    }

    const isWSL2 = Deno.env.get("WSL_DISTRO_NAME") !== undefined;
    isWSL2 &&
      await createSymlink(
        winDir.join("wsl.conf"),
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
      [commonDir.join("helix"), configDir.join("helix")],
      ...[".Brewfile", ".Brewfile.lock.json", ".gitconfig.mac"].map(
        (f) => [macDir.join(f), homeDir.join(f)],
      ),
      ...["skhd", "yabai"].map(
        (f) => [macDir.join(f), configDir.join(f)],
      ),
      [macDir.join("warp"), homeDir.join(".warp")],
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
      [winDir.join(".wslconfig"), homeDir.join(".wslconfig")],
      [
        winDir.join("terminal/settings.json"),
        homeDir.join(
          "AppData",
          "Local",
          "Packages",
          "Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe",
          "LocalState",
          "settings.json",
        ),
      ],
      [commonDir.join("helix"), homeDir.join("AppData", "Roaming", "helix")],
      [
        winDir.join("Microsoft.PowerShell_profile.ps1"),
        homeDir.join(
          "Documents",
          "PowerShell",
          "Microsoft.PowerShell_profile.ps1",
        ),
      ],
      [
        winDir.join("Microsoft.PowerShell_profile.ps1"),
        homeDir.join(
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
