import { exists } from "https://deno.land/std@0.217.0/fs/exists.ts";
import {
  dirname,
  fromFileUrl,
  resolve,
} from "https://deno.land/std@0.217.0/path/mod.ts";
import $ from "https://deno.land/x/dax@0.39.2/mod.ts";
import { parseArgs } from "https://deno.land/std@0.217.0/cli/parse_args.ts";

const flags: {
  "upgrade-winget"?: boolean;
} = parseArgs(Deno.args);

const home = Deno.env.get("USERPROFILE")!;
const rootDir = dirname(dirname(fromFileUrl(import.meta.url)));
const commonConfig = `${rootDir}/common/config`;
const windowsConfig = `${rootDir}/windows/config`;
const config = {
  // deno-fmt-ignore
  symlinks: {
    [`${home}/.config/aquaproj-aqua`]: `${commonConfig}/aquaproj-aqua`,
    [`${home}/.config/starship.toml`]: `${commonConfig}/starship.toml`,
    [`${home}/.gitconfig`]: `${windowsConfig}/.gitconfig`,
    [`${home}/.gittemplate.txt`]: `${commonConfig}/.gittemplate.txt`,
    [`${home}/.wezterm.lua`]: `${commonConfig}/.wezterm.lua`,
    [`${home}/.wslconfig`]: `${windowsConfig}/.wslconfig`,
    [`${home}/AppData/Local/nvim`]: `${commonConfig}/nvim`,
    [`${home}/AppData/Roaming/Code/User/settings.json`]: `${windowsConfig}/vscode/settings.json`,
    [`${home}/Microsoft.PowerShell_profile.ps1`]: `${windowsConfig}/Microsoft.PowerShell_profile.ps1`,
    [`${home}/Microsoft.VSCode_profile.ps1`]: `${windowsConfig}/Microsoft.PowerShell_profile.ps1`,
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
    ],
  },
};

$.logStep("Creating symlinks");
await $.logGroup(async () => {
  await Promise.all(
    Object.entries(config.symlinks).map(async ([_link, _target]) => {
      const link = resolve(_link);
      const target = resolve(_target);
      await exists(link) && await Deno.remove(link);
      await Deno.symlink(target, link);
      $.logStep(`Created ${link}`);
    }),
  );
});

$.logStep("Downloading fonts");
await $.logGroup(async () => {
  const { dist, links } = config.fonts;
  const fontBaseDir = resolve(dist);
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
