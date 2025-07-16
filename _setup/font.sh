#!/bin/bash -eux

echo "Download fonts"

mkdir -p ./dist
cd ./dist

# 源ノ角ゴシック
curl -O "https://github.com/adobe-fonts/source-han-sans/raw/release/Variable/OTF/Subset/SourceHanSansJP-VF.otf"
# 源ノ角ゴシック Code JP (Use OTF!)
curl -O "https://github.com/adobe-fonts/source-han-code-jp/archive/refs/heads/release.zip"
# Nerd Font
curl -O "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/NerdFontsSymbolsOnly/SymbolsNerdFont-Regular.ttf"

cd ..
