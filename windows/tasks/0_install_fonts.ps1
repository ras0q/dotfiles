$output = "~/AppData/Local/Microsoft/Windows/Fonts/SourceCodePro-Regular.otf"

if (Test-Path $output) {
  Write-Host "File already exists: $output"
  return
}

Invoke-WebRequest `
  -Uri https://github.com/adobe-fonts/source-code-pro/raw/release/OTF/SourceCodePro-Regular.otf `
  -OutFile $output `
  -UseBasicParsing
