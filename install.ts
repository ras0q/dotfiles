#!/usr/bin/env -S deno run -A

import { parseArgs } from "jsr:@std/cli@1.0.13/parse-args";
import { $, Path } from "jsr:@david/dax@0.42.0";

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
  const isMac = os === "darwin";
  const isWindows = os === "windows";
  const isWSL2 = isLinux && Deno.env.get("WSL_DISTRO_NAME") !== undefined;

  const symlinks = [
    ["./common/.bash_profile", "~/.bash_profile"],
    ["./common/.bashrc", "~/.bashrc"],
    ["./common/.gitconfig", "~/.gitconfig"],
    ["./common/.gittemplate.txt", "~/.gittemplate.txt"],
    ["./common/fish", "~/.config/fish"],
    ["./common/mise", "~/.config/mise"],
    ["./common/starship.toml", "~/.config/starship.toml"],
    ["./common/zellij", "~/.config/zellij"],
    ...(isLinux ? [["./common/helix", "~/.config/helix"]] : []),
    ...(isWSL2 ? [["./win/wsl.conf", "/etc/wsl.conf"]] : []),
    ...(isMac
      ? [
        ["./common/helix", "~/.config/helix"],
        ["./mac/.Brewfile", "~/.Brewfile"],
        ["./mac/.Brewfile.lock.json", "~/.Brewfile.lock.json"],
        ["./mac/.gitconfig.mac", "~/.gitconfig.mac"],
        ["./mac/skhd", "~/.config/skhd"],
        ["./mac/yabai", "~/.config/yabai"],
        ["./mac/warp", "~/.warp"],
      ]
      : []),
    ...(isWindows
      ? [
        ["./win/.wslconfig", "~/.wslconfig"],
        [
          "./win/terminal/settings.json",
          "~/AppData/Local/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json",
        ],
        ["./common/helix", "~/AppData/Roaming/helix"],
        [
          "./win/Microsoft.PowerShell_profile.ps1",
          "~/Documents/PowerShell/Microsoft.PowerShell_profile.ps1",
        ],
        [
          "./win/Microsoft.PowerShell_profile.ps1",
          "~/Documents/PowerShell/Microsoft.VSCode_profile.ps1",
        ],
      ]
      : []),
  ];

  await Promise.all(
    symlinks.map(([source, target]) => {
      const sourcePath = root.join(source);
      const targetPath = $.path(target.replace(/^~\//, `${home}/`));
      return createSymlink(sourcePath, targetPath, backupDir, canUseSudo);
    }),
  );

  const tasks = [
    ...(isLinux && canUseSudo ? ["apt"] : []),
    ...(isLinux && canUseSudo ? ["brew"] : []),
    ...(isWindows ? ["winget"] : []),
    "mise",
    ...(canInstallFonts ? ["font"] : []),
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
