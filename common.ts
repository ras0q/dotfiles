import $ from "@david/dax";
import { exists } from "@std/fs/exists";
import { resolve } from "@std/path/resolve";

export const infoLogger = (...args: []) => {
  console.log(`%c[INFO] ${args.join(" ")}`, "color: green; font-weight: bold;");
};

export const downloadFonts = async () => {
  const fontDir = prompt(
    "Enter the path to the font directory:",
    resolve(Deno.cwd(), "./dist/fonts"),
  )!;

  const fontURLs = [
    // 源ノ角ゴシック
    "https://github.com/adobe-fonts/source-han-sans/raw/release/Variable/OTF/Subset/SourceHanSansJP-VF.otf",
    // 源ノ角ゴシック Code
    "https://github.com/adobe-fonts/source-han-code-jp/raw/release/OTF/SourceHanCodeJP-Regular.otf",
    // Source Code Pro (Nerd Font)
    "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/SauceCodeProNerdFont-Regular.ttf",
    // Nerd Font
    "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/NerdFontsSymbolsOnly/SymbolsNerdFont-Regular.ttf",
  ];

  await $`mkdir -p ${fontDir}`;
  await Promise.all(
    fontURLs.map((url) => $.request(url).showProgress().pipeToPath(fontDir)),
  );
};

export const cloneDotfiles = async () => {
  const dotfilesDir = prompt(
    "Enter the path to the dotfiles directory:",
    Deno.cwd(),
  )!;

  if (await exists(dotfilesDir)) {
    $.logWarn("Skipped dotfiles clone");
    return;
  }

  await $`git clone https://github.com/ras0q/dotfiles-v2.git ${dotfilesDir} --depth 1`;
};
