import { exists } from "https://deno.land/std@0.217.0/fs/exists.ts";
import { resolve } from "https://deno.land/std@0.217.0/path/mod.ts";
import $ from "https://deno.land/x/dax@0.39.2/mod.ts";
import { parseArgs } from "https://deno.land/std@0.217.0/cli/parse_args.ts";

$.setPrintCommand(true);

const flags: {
  "dotfiles-dir"?: string;
  "upgrade-winget"?: boolean;
} = parseArgs(Deno.args);

const home = Deno.env.get("USERPROFILE")!;
const dirname = import.meta.dirname || Deno.exit(1);
const config = {
  // deno-fmt-ignore
  symlinks: {
    [`${home}/.config/aquaproj-aqua/`]: `./common/aquaproj-aqua`,
    [`${home}/.config/starship.toml`]: `./common/starship.toml`,
    [`${home}/.gitconfig`]: `./common/.gitconfig`,
    [`${home}/.gitconfig.win`]: `./win/.gitconfig.win`,
    [`${home}/.gittemplate.txt`]: `./common/.gittemplate.txt`,
    [`${home}/.wezterm.lua`]: `./common/.wezterm.lua`,
    [`${home}/.wslconfig`]: `./win/.wslconfig`,
    [`${home}/AppData/Local/nvim/`]: `./common/nvim`,
    [`${home}/AppData/Roaming/Code/User/settings.json`]: `./win/vscode/settings.json`,
    [`${home}/Documents/PowerShell/Microsoft.PowerShell_profile.ps1`]: `./win/Microsoft.PowerShell_profile.ps1`,
    [`${home}/Documents/PowerShell/Microsoft.VSCode_profile.ps1`]: `./win/Microsoft.PowerShell_profile.ps1`,
  },
  fonts: {
    links: [
      // 源ノ角ゴシック
      "https://github.com/adobe-fonts/source-han-sans/raw/release/Variable/OTF/Subset/SourceHanSansJP-VF.otf",
      // 源ノ角ゴシック Code
      "https://github.com/adobe-fonts/source-han-code-jp/raw/release/OTF/SourceHanCodeJP-Regular.otf",
      // Source Code Pro (Nerd Font)
      "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/SauceCodeProNerdFontMono-Regular.ttf",
    ],
    dist: "./dist/fonts",
  },
  winget: {
    link:
      "https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle",
    tmppath: "./winget.msixbundle",
    packages: [
      // Common GUI
      "wez.wezterm",
      "Microsoft.Edge",
      "Microsoft.VisualStudioCode",
      "AgileBits.1Password",
      "Discord.Discord",
      "Figma.Figma",
      "Google.GoogleDrive",
      "Obsidian.Obsidian",
      "LINE.LINE",
      "SlackTechnologies.Slack",
      "Spotify.Spotify",
      "OliverSchwendener.ueli",
      "Betterbird.Betterbird",
      // Common CLI
      "aquaproj.aqua",
      "Git.Git",
      // Only for Windows
      "Flow-Launcher.Flow-Launcher",
      "jstarks.npiperelay",
      "SomePythonThings.WingetUIStore",
      "Microsoft.PowerShell",
      "gerardog.gsudo",
      "voidtools.Everything",
      "Kitware.CMake",
    ],
  },
  nextSteps: [
    "Install fonts (from ./dist/fonts)",
    "Login to Microsoft Store",
    "Login to Microsoft Edge",
    "Login to Visual Studio Code (GitHub)",
    "Login to 1Password",
    "Login to Discord",
    "Login to Figma",
    "Login to Google Drive",
    "Clone your Obsidian vault (~/Documents/<vault-name> is recommended)",
    "Login to LINE",
    "Login to Slack",
    "Login to Spotify",
    "Import your ueli settings (from ./windows/data/ueli.config.json)",
    "Login to GitHub CLI",
  ],
};

$.logStep("Cloning dotfiles");
await $.logGroup(async () => {
  const dotfiles = "https://github.com/ras0q/dotfiles-v2.git";
  const dotfilesDir = flags["dotfiles-dir"]
    ? resolve(dirname, flags["dotfiles-dir"])
    : resolve(home, "ghq/github.com/ras0q/dotfiles-v2");
  if (await exists(dotfilesDir)) {
    $.logStep("Skipped dotfiles clone");
  } else {
    await $`git clone ${dotfiles} ${dotfilesDir} --depth 1`;
    $.logStep(`Cloned ${dotfilesDir}`);
  }
});

$.logStep("Creating symlinks");
await $.logGroup(async () => {
  await Promise.all(
    Object.entries(config.symlinks).map(async ([_link, _target]) => {
      const link = $.path(_link).resolve();
      const target = $.path(`${dirname}/${_target}`).resolve();
      await $`rm -rf ${link}`;
      await link.createSymlinkTo(target, {
        kind: "absolute",
        type: _link.endsWith("/") ? "dir" : "file", // only for Windows
      });
      $.logStep(`Created ${link}`);
    }),
  );
});

$.logStep("Downloading fonts");
await $.logGroup(async () => {
  const { dist, links } = config.fonts;
  const fontBaseDir = resolve(dirname, dist);
  await $`mkdir -p ${fontBaseDir}`;
  await Promise.all(links.map(async (font) => {
    const fontPath = resolve(fontBaseDir, font.split("/").slice(-1)[0]);
    const data = await $.request(font).showProgress();
    await Deno.writeFile(fontPath, new Uint8Array(await data.arrayBuffer()));
    $.logStep(`Downloaded ${fontPath}`);
  }));
});

$.logStep("Setting up winget and packages");
await $.logGroup(async () => {
  const { link, tmppath, packages } = config.winget;
  if (
    flags["upgrade-winget"] ||
    !((await $`pwsh -c Get-Command winget`.stdout("null")).code === 0)
  ) {
    $.logStep("Installing winget");
    const data = await $.request(link).showProgress();
    await Deno.writeFile(tmppath, new Uint8Array(await data.arrayBuffer()));
    await $`pwsh -c Add-AppxPackage -Path ${tmppath}`;
    await $`rm ${tmppath}`;
    $.logStep("Installed winget");
  } else {
    $.logStep("Skipped winget installation");
  }

  $.logStep("Installing winget packages");
  const command = [
    "winget",
    "install",
    "--accept-source-agreements",
    "--accept-package-agreements",
    "--silent",
    ...packages,
  ].join(" ");
  // TODO: why this command throws an error?
  // error: Uncaught (in promise) Error: Exited with code: 1
  //           throw new Error(`Exited with code: ${code}`);
  //                 ^
  //   at CommandChild.pipedStdoutBuffer (https://deno.land/x/dax@0.39.2/src/command.ts:758:19)
  //   at eventLoopTick (ext:core/01_core.js:153:7)
  await $`pwsh -c ${command}`.noThrow();
  $.logStep("Installed winget packages");
});

$.logStep("Setting up aquaproj");
await $.logGroup(async () => {
  await $.commandExists("aqua") || $.logError("aqua is not installed");
  await $`aqua install --all`;
});

$.log("Set up complete🎉🎉🎉");

$.log("Next steps");
$.logGroup(() => {
  for (const step of config.nextSteps) {
    $.log(step);
  }
});
