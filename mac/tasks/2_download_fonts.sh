#!/bin/sh -eu

# https://scrapbox.io/ras0q/フォント2023

fontDir="./mac/dist/fonts"
fonts=(
  "https://github.com/adobe-fonts/source-han-sans/raw/release/Variable/OTF/Subset/SourceHanSansJP-VF.otf"
  "https://github.com/adobe-fonts/source-han-code-jp/raw/release/OTF/SourceHanCodeJP-Regular.otf"
  "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/SauceCodeProNerdFontMono-Regular.ttf"
)

mkdir -p $fontDir

for font in "${fonts[@]}"; do
  uri="$font"
  output="$fontDir/$(basename $font)"
  if [ -f "$output" ]; then
    echo "File already exists: $output"
    continue
  fi

  echo "Downloading $uri to $output"
  curl -sSL "$uri" -o "$output"
done
