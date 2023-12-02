# Create symbolic links (Path -> Target)

gsudo {
  $baseDir = (Get-Item -Path ".\").FullName

  # Common files
  $confDir = "$baseDir\common\config"
  ## $HOME
  New-Item -ItemType SymbolicLink -Force -Path $HOME\.config\aquaproj-aqua -Target $confDir\aquaproj-aqua
  New-Item -ItemType SymbolicLink -Force -Path $HOME\AppData\Local\nvim -Target $confDir\nvim
  New-Item -ItemType SymbolicLink -Force -Path $HOME\.gittemplate.txt -Target $confDir\.gittemplate.txt
  New-Item -ItemType SymbolicLink -Force -Path $HOME\.wezterm.lua -Target $confDir\.wezterm.lua
  New-Item -ItemType SymbolicLink -Force -Path $HOME\.config\starship.toml -Target $confDir\starship.toml

  # OS specific files
  $confDir = "$baseDir\windows\config"
  ## $HOME
  New-Item -ItemType SymbolicLink -Force -Path $HOME\.gitconfig -Target $confDir\.gitconfig
  New-Item -ItemType SymbolicLink -Force -Path $HOME\.wslconfig -Target $confDir\.wslconfig
  New-Item -ItemType SymbolicLink -Force -Path $HOME\AppData\Roaming\Code\User\settings.json -Target $confDir\vscode\settings.json
  ## $PROFILE (sync also VSCode_profile)
  New-Item -ItemType SymbolicLink -Force -Path $PROFILE -Target $confDir\Microsoft.PowerShell_profile.ps1
  New-Item -ItemType SymbolicLink -Force -Path $PROFILE.Replace("PowerShell_profile", "VSCode_profile") -Target $confDir\Microsoft.PowerShell_profile.ps1
}
