import { exists } from "jsr:@std/fs@0.229.0";
import { resolve } from "jsr:@std/path@0.225.0";
import { parseArgs } from "jsr:@std/cli@0.224.0";
import $ from "jsr:@david/dax@0.41.0";

$.setInfoLogger((...args) => {
  console.log(`%c[INFO] ${args.join(" ")}`, "color: green; font-weight: bold;");
});

const flags: {
  "download-fonts"?: boolean;
  "upgrade-winget"?: boolean;
} = parseArgs(Deno.args);

const home = Deno.env.get("USERPROFILE")!;
const dotfilesDir = resolve(home, "ghq/github.com/ras0q/dotfiles-v2");

await $.logGroup("Cloning dotfiles", async () => {
  if (await exists(dotfilesDir)) {
    $.log("Skipped dotfiles clone");
    return;
  }

  await $`git clone https://github.com/ras0q/dotfiles-v2.git ${dotfilesDir} --depth 1`;
  $.log(`Cloned dotfiles to ${dotfilesDir}`);
});

await $.logGroup("Creating symlinks", async () => {
  const symlinks: string[][] = [
    [`${home}/.config/aquaproj-aqua/`, "./common/aquaproj-aqua/"],
    [`${home}/.config/starship.toml`, "./common/starship.toml"],
    [`${home}/.gitconfig`, "./common/.gitconfig"],
    [`${home}/.gitconfig.win`, "./win/.gitconfig.win"],
    [`${home}/.gittemplate.txt`, `./common/.gittemplate.txt`],
    [`${home}/.wezterm.lua`, `./common/.wezterm.lua`],
    [`${home}/.wslconfig`, `./win/.wslconfig`],
    [`${home}/AppData/Local/nvim/`, `./common/nvim/`],
    [
      `${home}/AppData/Local/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json`,
      `./win/terminal/settings.json`,
    ],
    [
      `${home}/AppData/Roaming/Code/User/settings.json`,
      `./win/vscode/settings.json`,
    ],
    [`${home}/AppData/Roaming/helix/`, `./common/helix/`],
    [
      `${home}/Documents/PowerShell/Microsoft.PowerShell_profile.ps1`,
      `./win/Microsoft.PowerShell_profile.ps1`,
    ],
    [
      `${home}/Documents/PowerShell/Microsoft.VSCode_profile.ps1`,
      `./win/Microsoft.PowerShell_profile.ps1`,
    ],
  ];
  await Promise.all(
    symlinks.map(async ([link, target]) => {
      const linkPath = $.path(resolve(link));
      const targetPath = $.path(resolve(dotfilesDir, target));
      await $`rm -rf ${link}`;
      if (!(await exists(linkPath.dirname().toString()))) {
        await $`mkdir -p ${linkPath.dirname()}`;
      }
      await linkPath.symlinkTo(target, {
        kind: "absolute",
        type: targetPath.isDirSync() ? "dir" : "file", // only for Windows
      });
      $.log(`Created symlink: ${linkPath} -> ${targetPath}`);
    }),
  );
});

if (flags["download-fonts"]) {
  await $.logGroup("Downloading fonts", async () => {
    const fonts = [
      // 源ノ角ゴシック
      "https://github.com/adobe-fonts/source-han-sans/raw/release/Variable/OTF/Subset/SourceHanSansJP-VF.otf",
      // 源ノ角ゴシック Code
      "https://github.com/adobe-fonts/source-han-code-jp/raw/release/OTF/SourceHanCodeJP-Regular.otf",
      // Source Code Pro (Nerd Font)
      "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/SauceCodeProNerdFont-Regular.ttf",
      // Nerd Font
      "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/NerdFontsSymbolsOnly/SymbolsNerdFont-Regular.ttf",
    ];
    const fontBaseDir = resolve(dotfilesDir, "./dist/fonts");

    await $`mkdir -p ${fontBaseDir}`;
    await Promise.all(fonts.map(async (font) => {
      const fontPath = resolve(fontBaseDir, font.split("/").slice(-1)[0]);
      const data = await $.request(font).showProgress();
      await Deno.writeFile(fontPath, new Uint8Array(await data.arrayBuffer()));
      $.log(`Downloaded ${fontPath}`);
    }));
  });
}

if (!$.commandExists("winget") || flags["upgrade-winget"]) {
  $.logGroup("Installing latest winget", async () => {
    const wingetLink =
      "https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle";
    const data = await $.request(wingetLink).showProgress();
    const wingetTmpPath = "./winget.msixbundle";
    await Deno.writeFile(
      wingetTmpPath,
      new Uint8Array(await data.arrayBuffer()),
    );
    await $`pwsh -c Add-AppxPackage -Path ${wingetTmpPath}`;
    await $`rm ${wingetTmpPath}`;
    $.log("Installed winget");
  });
} else {
  $.log("Skipped winget installation");
}

await $.logGroup("Installing winget packages", async () => {
  const wingetPackages = [
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
    "TheBrowserCompany.Arc",
    "SlackTechnologies.Slack",
    "Spotify.Spotify",
    // Common CLI
    "aquaproj.aqua",
    "Git.Git",
    // Only for Windows
    "jstarks.npiperelay",
    "SomePythonThings.WingetUIStore",
    "Microsoft.PowerShell",
    "Microsoft.PowerToys",
    "Microsoft.WindowsTerminal.Preview",
    "gerardog.gsudo",
    "Kitware.CMake",
  ];
  const command = [
    "winget",
    "install",
    "--accept-source-agreements",
    "--accept-package-agreements",
    "--silent",
    ...wingetPackages,
  ].join(" ");
  // TODO: why this command throws an error?
  // error: Uncaught (in promise) Error: Exited with code: 1
  //           throw new Error(`Exited with code: ${code}`);
  //                 ^
  //   at CommandChild.pipedStdoutBuffer (https://deno.land/x/dax@0.39.2/src/command.ts:758:19)
  //   at eventLoopTick (ext:core/01_core.js:153:7)
  await $`pwsh -c ${command}`.noThrow();
  $.log("Installed winget packages");
});

await $.logGroup("Installing aquaproj", async () => {
  if (await $.commandExists("aqua")) {
    $.logError("aqua is not installed. Install it first with winget");
    return;
  }
});

await $.logGroup("Installing aquaproj packages", async () => {
  await $`aqua install --all`;
  $.log("Installed aquaproj packages");
});

$.logGroup("Set up complete🎉🎉🎉", () => {
  $.log("Next steps");
  const nextSteps = [
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
  ];
  for (const step of nextSteps) {
    $.log(`- [ ] ${step}`);
  }
});
