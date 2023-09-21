# Create symbolic links (Path -> Target)

gsudo {
  $baseDir = (Get-Item -Path ".\").FullName

  # Common files
  $confDir = "$baseDir\common\config"
  ## $HOME
  New-Item -ItemType SymbolicLink -Force -Path $HOME\.gittemplate.txt -Target $confDir\.gittemplate.txt
  New-Item -ItemType SymbolicLink -Force -Path $HOME\.wezterm.lua -Target $confDir\.wezterm.lua

  # OS specific files
  $confDir = "$baseDir\windows\config"
  ## $HOME
  New-Item -ItemType SymbolicLink -Force -Path $HOME\.gitconfig -Target $confDir\.gitconfig
  ## $PROFILE
  New-Item -ItemType SymbolicLink -Force -Path $PROFILE -Target $confDir\Microsoft.PowerShell_profile.ps1
}
