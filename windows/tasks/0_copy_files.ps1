$now = Get-Date -UFormat "%Y%m%d-%H%M%S"
$backupDir = ".\backup\" + $now + "\"
if (!(Test-Path $backupDir)) {
  New-Item -ItemType Directory -Path $backupDir
}

function Copy-Backup($source, $destination) {
  Copy-Item $destination $backupDir -Recurse
  Copy-Item $source $destination -Recurse
}

# Copy common files
$commonDir = ".\common\files"
Copy-Backup $commonDir\.wezterm.lua $HOME\.wezterm.lua

# Copy OS specific files
$windowsDir = ".\windows\files"
$windowsGenDir = $windowsDir + "\generated"
Copy-Backup $windowsGenDir\.gitconfig $HOME\.gitconfig
