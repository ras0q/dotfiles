#!/bin/bash

export PS4='\[\e[1;36m\]+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME:+$FUNCNAME(): }\[\e[m\]'
export __STEP__="echo -e \e[1;32m\n#"

os=$(uname)
if [[ "$os" != "Linux" && "$os" != "Darwin" ]]; then
    echo "Unsupported OS"
    exit 1
fi

command -v sudo && sudo -v && is_sudoer=true || is_sudoer=false

echo "Environment:
    OS: $os
    Sudoer: $is_sudoer
"

root=$(git rev-parse --show-toplevel)
cd $root

set -eux

$__STEP__ "Create symlinks"

ln -sfn $root/common/.bash_profile    ~/.bash_profile
ln -sfn $root/common/.bashrc          ~/.bashrc
ln -sfn $root/common/.gitconfig       ~/.gitconfig
ln -sfn $root/common/.gittemplate.txt ~/.gittemplate.txt
mkdir -p ~/.config
ln -sfn $root/common/aquaproj-aqua    ~/.config/aquaproj-aqua
ln -sfn $root/common/fish             ~/.config/fish
ln -sfn $root/common/helix            ~/.config/helix
ln -sfn $root/common/nvim             ~/.config/nvim
mkdir -p ~/.rye
ln -sfn $root/rye/config.toml         ~/.rye/config.toml

$__STEP__ "Setup for $os"

case "$os" in
    Linux)
        if [[ "$(uname -r)" == *-microsoft-standard-WSL2 ]]; then
            ln -sfn $root/common/vscode/extensions.json ~/.vscode-server/extensions/extensions.json
            ln -sfn $root/common/vscode/settings.json   ~/.vscode-server/data/Machine/settings.json
            $is_sudoer && sudo ln -sfn $root/wsl/wsl.conf /etc/wsl.conf
        fi
    
        if command -v apt >/dev/null 2>&1; then
            $is_sudoer && ./setup/apt.sh
            ./setup/aqua.sh
            ./setup/font.sh
        else
            echo "Unsupported Linux distribution"
            exit 1
        fi
        ;;

    Darwin)
        ln -sfn $root/mac/.Brewfile           ~/.Brewfile
        ln -sfn $root/mac/.Brewfile.lock.json ~/.Brewfile.lock.json
        ln -sfn $root/mac/.gitconfig.mac      ~/.gitconfig.mac
        ln -sfn $root/mac/skhd                ~/.config/skhd
        ln -sfn $root/mac/yabai               ~/.config/yabai
        ln -sfn $root/mac/warp                ~/.warp

        ./setup/brew.sh
        ./setup/rustup.sh
        ./setup/aqua.sh
        ./setup/font.sh
        ;;
esac
