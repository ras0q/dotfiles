#!/bin/bash -eux

$__STEP__ "Download fonts"

mkdir -p ./dist
cd ./dist

# 源ノ角ゴシック
curl -O "https://github.com/adobe-fonts/source-han-sans/raw/release/Variable/OTF/Subset/SourceHanSansJP-VF.otf"
# 源ノ角ゴシック Code
curl -O "https://github.com/adobe-fonts/source-han-code-jp/raw/release/OTF/SourceHanCodeJP-Regular.otf"
# Source Code Pro (Nerd Font)
curl -O "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/SauceCodeProNerdFont-Regular.ttf"
# Nerd Font
curl -O "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/NerdFontsSymbolsOnly/SymbolsNerdFont-Regular.ttf"

cd ..
