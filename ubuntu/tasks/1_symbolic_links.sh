#!/bin/bash -eux

# Common files
confDir="$PWD/common/config"
## $HOME
sudo ln -sf $confDir/.asdfrc $HOME
sudo ln -sf $confDir/.gittemplate.txt $HOME
## $HOME/.config
sudo ln -sf $confDir/aquaproj-aqua $HOME/.config
sudo ln -sf $confDir/fish $HOME/.config
sudo ln -sf $confDir/nvim $HOME/.config
sudo ln -sf $confDir/starship.toml $HOME/.config

# OS specific files
confDir="$PWD/ubuntu/config"
## $HOME
sudo ln -sf $confDir/.Brewfile $HOME
sudo ln -sf $confDir/.gitconfig $HOME
## /etc
### WSl2 only
if [[ "$(uname -r)" == *microsoft* ]]; then
  sudo ln -sf $confDir/wsl.conf /etc
fi
