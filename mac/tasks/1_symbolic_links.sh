#!/bin/sh -eu

# Common files
confDir="$PWD/common/config"
## $HOME
sudo ln -sf $confDir/.asdfrc $HOME
sudo ln -sf $confDir/.gittemplate.txt $HOME
sudo ln -sf $confDir/.wezterm.lua $HOME
## $HOME/.config
sudo ln -sf $confDir/nvim $HOME/.config
sudo ln -sf $confDir/starship.toml $HOME/.config

# OS specific files
confDir="$PWD/mac/config"
## $HOME
sudo ln -sf $confDir/.Brewfile $HOME
sudo ln -sf $confDir/.Brewfile.lock.json $HOME
sudo ln -sf $confDir/.gitconfig $HOME
