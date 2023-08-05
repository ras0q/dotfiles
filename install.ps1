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

Write-Info "Next steps:"
# common
Write-Info "  - [ ] Login to Microsoft Store"
# winget
Write-Info "  - [ ] Login to Microsoft Edge"
Write-Info "  - [ ] Login to Visual Studio Code (GitHub)"
Write-Info "  - [ ] Login to 1Password"
Write-Info "  - [ ] Login to Discord"
Write-Info "  - [ ] Login to Figma"
Write-Info "  - [ ] Login to Google Drive"
Write-Info "  - [ ] Clone your Obsidian vault (~/Documents/<vault-name> is recommended)"
Write-Info "  - [ ] Login to LINE"
Write-Info "  - [ ] Login to Slack"
Write-Info "  - [ ] Login to Spotify"
Write-Info "  - [ ] Import your ueli settings (from ./windows/files/generated/ueli.config.json)"
Write-Info "  - [ ] Login to GitHub CLI"
