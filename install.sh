#!/bin/bash -eu

export ESC=$(printf '\033')
export RESET="${ESC}[0m"
export GREEN="${ESC}[32m"
export CYAN="${ESC}[36m"

export PS4='${CYAN}+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME:+$FUNCNAME(): }${RESET}'
export __STEP__="echo -e \n${GREEN}#"

trap "echo SIGINT; exit 1" SIGINT

os=$(uname)

sudoer_mode=false
read -n1 -p "Sudoer mode? (y/N)" yn; echo
[[ $yn = [yY] ]] && sudo -v >/dev/null 2>&1 && sudoer_mode=true

read -p "Press enter to continue (OS: $os, Sudoer mode: $sudoer_mode)"

root=$(git rev-parse --show-toplevel)
cd $root

backup_dir=$root/.backup/$(date -Iseconds)
mkdir -p $backup_dir
echo "*" > $backup_dir/.gitignore

function symlink() {
    sudo_prefix=""
    [[ $# -ge 3 && "$3" == "--sudo" ]] && sudo_prefix="sudo"
    [[ -e "$2" ]] && $sudo_prefix mv "$2" $backup_dir
    $sudo_prefix ln -sfn "$1" "$2"
}

set -x

$__STEP__ "Create symlinks"

# enable to create synlinks in Git Bash
[[ "$os" = MINGW* ]] && export MSYS=winsymlinks:nativestrict

symlink $root/common/.bash_profile    ~/.bash_profile
symlink $root/common/.bashrc          ~/.bashrc
symlink $root/common/.gitconfig       ~/.gitconfig
symlink $root/common/.gittemplate.txt ~/.gittemplate.txt
mkdir -p ~/.config
symlink $root/common/gitmoji-nodejs   ~/.config/gitmoji-nodejs
symlink $root/common/fish             ~/.config/fish
symlink $root/common/mise             ~/.config/mise
symlink $root/common/starship.toml    ~/.config/starship.toml
symlink $root/common/zellij           ~/.config/zellij

$__STEP__ "Setup for $os"

case "$os" in
    Linux)
        symlink $root/common/helix            ~/.config/helix

        if [[ "$(uname -r)" == *-microsoft-standard-WSL2 ]]; then
            $sudoer_mode && symlink $root/win/wsl.conf /etc/wsl.conf --sudo
        fi

        if command -v apt >/dev/null 2>&1; then
            $sudoer_mode && ./_setup/apt.sh
            ./_setup/mise.sh
            ./_setup/rustup.sh
            ./_setup/font.sh
        else
            echo "Unsupported Linux distribution"
            exit 1
        fi
        ;;

    Darwin)
        symlink $root/common/helix            ~/.config/helix
        symlink $root/mac/.Brewfile           ~/.Brewfile
        symlink $root/mac/.Brewfile.lock.json ~/.Brewfile.lock.json
        symlink $root/mac/.gitconfig.mac      ~/.gitconfig.mac
        symlink $root/mac/skhd                ~/.config/skhd
        symlink $root/mac/yabai               ~/.config/yabai
        symlink $root/mac/warp                ~/.warp

        $sudoer_mode && ./_setup/brew.sh
        ./_setup/mise.sh
        ./_setup/rustup.sh
        ./_setup/font.sh
        ;;

    MINGW*)
        symlink $root/win/.wslconfig                       ~/.wslconfig
        symlink $root/win/terminal/settings.json           ~/AppData/Local/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json
        symlink $root/common/helix                         ~/AppData/Roaming/helix
        symlink $root/win/Microsoft.PowerShell_profile.ps1 ~/Documents/PowerShell/Microsoft.PowerShell_profile.ps1
        symlink $root/win/Microsoft.PowerShell_profile.ps1 ~/Documents/PowerShell/Microsoft.VSCode_profile.ps1

        ./_setup/winget.sh
        ./_setup/rustup.sh
        ./_setup/font.sh
        ;;

    MSYS*)
        windows_home=/c/Users/$(whoami)
        localappdata=$windows_home/AppData/Local

        symlink $root/win/.wslconfig                       $windows_home/.wslconfig
        symlink $root/win/terminal/settings.json           $windows_home/AppData/Local/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json
        symlink $root/win/vscode/settings.json             $windows_home/AppData/Roaming/Code/User/settings.json
        symlink $root/common/helix                         $windows_home/AppData/Roaming/helix

        ./_setup/pacman.sh
        ./_setup/winget.sh
        ./_setup/rustup.sh
        ./_setup/font.sh
	;;


    *)
        echo "Unsupported OS"
        exit 1
        ;;
esac
