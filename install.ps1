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
