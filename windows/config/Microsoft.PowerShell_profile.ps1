# Path: $PROFILE/Microsoft.PowerShell_profile.ps1

Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadLineOption -PredictionSource History

# Additional paths
$env:Path += ";$HOME\AppData\Local\1Password\app\8"
