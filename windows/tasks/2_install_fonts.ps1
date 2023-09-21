# https://scrapbox.io/ras0q/フォント2023

$fontDir = "~/AppData/Local/Microsoft/Windows/Fonts"
$fonts = @(
  [pscustomobject]@{
    uri="https://github.com/adobe-fonts/source-han-sans/raw/release/Variable/OTF/Subset/SourceHanSansJP-VF.otf";
    output=$fontDir + "/SourceHanSansJP-VF.otf"
  }
  [pscustomobject]@{
    uri="https://github.com/adobe-fonts/source-han-code-jp/raw/release/OTF/SourceHanCodeJP-Regular.otf";
    output=$fontDir + "/SourceHanCodeJP-Regular.otf"
  }
  [pscustomobject]@{
    uri="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/SauceCodeProNerdFontMono-Regular.ttf";
    output=$fontDir + "/SauceCodeProNerdFontMono-Regular.ttf"
  }
)

foreach ($font in $fonts) {
  if (Test-Path $font.output) {
    Write-Host File already exists: $font.output
    continue
  }

  Write-Host Downloading $font.uri to $font.output
  Invoke-WebRequest `
    -Uri $font.uri `
    -OutFile $font.output `
    -UseBasicParsing
}
