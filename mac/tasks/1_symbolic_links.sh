#!/bin/sh -eu

# Common files
confDir="$PWD/common/config"
## $HOME
ln -sf $confDir/.bash_profile $HOME
ln -sf $confDir/.bashrc $HOME
ln -sf $confDir/.gittemplate.txt $HOME
ln -sf $confDir/.wezterm.lua $HOME
## $HOME/.config
mkdir -p $HOME/.config
ln -sf $confDir/aquaproj-aqua $HOME/.config/
ln -sf $confDir/fish $HOME/.config/
ln -sf $confDir/nvim $HOME/.config/
ln -sf $confDir/starship.toml $HOME/.config/
## $HOME/.rye
mkdir -p $HOME/.rye
ln -sf $confDir/rye/config.toml $HOME/.rye

# OS specific files
confDir="$PWD/mac/config"
## $HOME
ln -sf $confDir/.Brewfile $HOME
ln -sf $confDir/.Brewfile.lock.json $HOME
ln -sf $confDir/.gitconfig $HOME
