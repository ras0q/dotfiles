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

function gf() {
  ghq list -p | fzf | % { cd $_ }
}

Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadLineOption -PredictionSource History

# Additional paths
$env:Path += ";$HOME\AppData\Local\1Password\app\8"
$env:Path += ";$HOME\scoop\apps\gcc\current\bin"
# $env:Path += ";$HOME\.rye\shims"

# Aliases
Set-Alias powershell pwsh

# Starship
Invoke-Expression (&starship init powershell)
