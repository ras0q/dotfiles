#!/bin/sh

confDir="$PWD/common/config"
sudo ln -sf $confDir/nvim $HOME/.config/nvim
sudo ln -sf $confDir/.gittemplate.txt $HOME/.gittemplate.txt
sudo ln -sf $confDir/starship.toml $HOME/.config/starship.toml
