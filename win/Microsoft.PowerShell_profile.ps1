# Path: $PROFILE/Microsoft.PowerShell_profile.ps1

function Set-Path() {
  $env:Path = "$HOME\AppData\Local\1Password\app\8;$HOME\.cargo\bin;$HOME\AppData\Local\mise\shims;" `
    + [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + `
    [System.Environment]::GetEnvironmentVariable("Path", "User")
}

function Call($batfile) {
  cmd.exe /c "call `"${batfile}`" && set > %temp%\vars.txt"
  Get-Content "${env:temp}\vars.txt" | Foreach-Object {
    if ($_ -match "^(.*?)=(.*)$") {
      Set-Content "env:\$($matches[1])" $matches[2]
    }
  }
}

Set-PsReadLineKeyHandler -Chord Ctrl+r -ScriptBlock {
  $command = Get-Content (Get-PSReadLineOption).HistorySavePath | fzf --scheme=history --tac
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert($command)
}

Set-PSReadLineKeyHandler -Key Tab -Function Complete

# mute
Set-PSReadLineOption -BellStyle None

# Environment variables
$env:LESSCHARSET = "utf-8"

# Set PATH
Set-Path

# Aliases & Functions
Set-Alias powershell pwsh
# Git
function ga() { git add -A && git commit }
function gc() { git commit }
function gs($branch) { git switch $branch }
function gpu() { git push }
function gpp() { git pull && git bprune }
# ghq
function gf() { ghq list -p | fzf | ForEach-Object { Set-Location $_ } }
function gg($repo) { ghq get $repo }

# Starship
Invoke-Expression (&starship init powershell)
