# Create symbolic links (Path -> Value)

gsudo {
  # Common files
  $confDir = ".\common\config"
  ## $HOME
  New-Item -ItemType SymbolicLink -Path $HOME\.gittemplate.txt -Value $confDir\.gittemplate.txt
  New-Item -ItemType SymbolicLink -Path $HOME\.wezterm.lua -Value $confDir\.wezterm.lua

  # OS specific files
  $confDir = ".\windows\config"
  ## $HOME
  New-Item -ItemType SymbolicLink -Path $HOME\.gitconfig -Value $confDir\.gitconfig
  ## $PROFILE
  New-Item -ItemType SymbolicLink -Path $PROFILE -Value $confDir\Microsoft.PowerShell_profile.ps1
}
