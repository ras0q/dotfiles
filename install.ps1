function Write-Info($message) {
  Write-Host "[" -NoNewline
  Write-Host -ForegroundColor Green "INFO" -NoNewline
  Write-Host "] " -NoNewline
  Write-Host $message
}

# .\windows\tasks以下のタスクを逐次実行します
try {
  Get-ChildItem .\windows\tasks | ForEach-Object {
    Write-Info "$($_.BaseName): Executing..."
    & $_.FullName
    Write-Info "$($_.BaseName): Done!"
  }
  Write-Info "All tasks are done!"
}
catch {
  Write-Error $_.Exception.Message
  exit 1
}

Write-Host "Next steps:"
# common
Write-Host "  - [ ] Login to Microsoft Store"
# winget
Write-Host "  - [ ] Login to Microsoft Edge"
Write-Host "  - [ ] Login to Visual Studio Code (GitHub)"
Write-Host "  - [ ] Login to 1Password"
Write-Host "  - [ ] Login to Discord"
Write-Host "  - [ ] Login to Figma"
Write-Host "  - [ ] Login to Google Drive"
Write-Host "  - [ ] Clone your Obsidian vault (~/Documents/<vault-name> is recommended)"
Write-Host "  - [ ] Login to LINE"
Write-Host "  - [ ] Login to Slack"
Write-Host "  - [ ] Login to Spotify"
Write-Host "  - [ ] Import your ueli settings (from ./windows/files/generated/ueli.config.json)"
Write-Host "  - [ ] Login to GitHub CLI"
