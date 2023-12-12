Invoke-WebRequest `
  -Uri https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle `
  -OutFile winget.msixbundle `
  -UseBasicParsing
Add-AppxPackage -Path winget.msixbundle
Remove-Item winget.msixbundle

winget install `
  --accept-source-agreements `
  --accept-package-agreements `
  --silent `
  <# Common GUI #> `
  "wez.wezterm" `
  "Microsoft.Edge" `
  "Microsoft.VisualStudioCode" `
  "AgileBits.1Password" `
  "Discord.Discord" `
  "Figma.Figma" `
  "Google.GoogleDrive" `
  "Obsidian.Obsidian" `
  "LINE.LINE" `
  "SlackTechnologies.Slack" `
  "Spotify.Spotify" `
  "OliverSchwendener.ueli" `
  <# Common CLI #> `
  "aquaproj.aqua" `
  "Git.Git" `
  <# Only for Windows #> `
  "SomePythonThings.WingetUIStore" `
  "Microsoft.PowerShell" `
  "gerardog.gsudo" `
  "voidtools.Everything"
