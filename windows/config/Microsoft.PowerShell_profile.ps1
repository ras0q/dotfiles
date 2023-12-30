# Path: $PROFILE/Microsoft.PowerShell_profile.ps1

function Set-New-Path() {
  $env:Path = `
    [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + `
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

Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadLineOption -PredictionSource History

# Environment variables
$env:AQUA_GLOBAL_CONFIG = "$HOME\.config\aquaproj-aqua\aqua.yaml"

# Additional paths
$env:Path += ";$HOME\AppData\Local\1Password\app\8"
$env:Path += ";$HOME\scoop\apps\gcc\current\bin"
$env:Path += ";$HOME\.rye\shims"
$env:Path += ";$HOME\AppData\Local\Volta\bin"
$env:Path += ";$HOME\AppData\Local\aquaproj-aqua\bat"
$env:Path += ";$HOME\AppData\Local\aquaproj-aqua\bin"

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
