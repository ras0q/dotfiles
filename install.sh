#!/bin/bash

export PS4='\[\e[1;36m\]+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME:+$FUNCNAME(): }\[\e[m\]'
export __STEP__="echo -e \e[1;32m\n#"

os=$(uname)

sudoer_mode=false
read -n1 -p "Sudoer mode? (y/N)" yn
echo ""
if [[ $yn = [yY] ]]; then
    command -v sudo >/dev/null 2>&1 && sudo -v && sudoer_mode=true || exit 1
fi

read -p "Press enter to continue (OS: $os, Sudoer mode: $sudoer_mode)"

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
ln -sfn $root/common/gitmoji-nodejs   ~/.config/gitmoji-nodejs
ln -sfn $root/common/fish             ~/.config/fish
ln -sfn $root/common/helix            ~/.config/helix

$__STEP__ "Setup for $os"

case "$os" in
    Linux)
        if [[ "$(uname -r)" == *-microsoft-standard-WSL2 ]]; then
            ln -sfn $root/common/vscode/extensions.json ~/.vscode-server/extensions/extensions.json
            ln -sfn $root/common/vscode/settings.json   ~/.vscode-server/data/Machine/settings.json
            $sudoer_mode && sudo ln -sfn $root/wsl/wsl.conf /etc/wsl.conf
        fi
    
        if command -v apt >/dev/null 2>&1; then
            $sudoer_mode && ./setup/apt.sh
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

    MINGW*)
        # enable to create synlinks in Git Bash
        export MSYS=winsymlinks:nativestrict
        ln -sfn $root/win/.wslconfig                       ~/.wslconfig
        ln -sfn $root/win/terminal/settings.json           ~/AppData/Local/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json
        ln -sfn $root/win/vscode/settings.json             ~/AppData/Roaming/Code/User/settings.json
        ln -sfn $root/common/helix                         ~/AppData/Roaming/helix
        ln -sfn $root/win/Microsoft.PowerShell_profile.ps1 ~/Documents/PowerShell/Microsoft.PowerShell_profile.ps1
        ln -sfn $root/win/Microsoft.PowerShell_profile.ps1 ~/Documents/PowerShell/Microsoft.VSCode_profile.ps1

        ./setup/winget.sh
        ./setup/aqua.sh
        ./setup/font.sh
        ;;

    *)
        echo "Unsupported OS"
        exit 1
        ;;
esac
