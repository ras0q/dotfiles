$now = Get-Date -UFormat "%Y%m%d-%H%M%S"
$backupDir = ".\backup\" + $now + "\"
if (!(Test-Path $backupDir)) {
  New-Item -ItemType Directory -Path $backupDir > $null
}

function Copy-Backup($source, $destination) {
  Copy-Item $destination $backupDir -Recurse
  $destinationDir = Split-Path $destination
  if (!(Test-Path $destinationDir)) {
    New-Item -ItemType Directory -Path $destinationDir > $null
  }
  Copy-Item $source $destination -Recurse
}

# Copy common files
$commonDir = ".\common\files"
Copy-Backup $commonDir\.wezterm.lua $HOME\.wezterm.lua

# Copy OS specific files
$windowsDir = ".\windows\files"
Copy-Backup $windowsDir\Microsoft.PowerShell_profile.ps1 $PROFILE
$windowsGenDir = $windowsDir + "\generated"
Copy-Backup $windowsGenDir\.gitconfig $HOME\.gitconfig
