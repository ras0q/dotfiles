#!/bin/bash

DOTFILES_DIR=~/ghq/github.com/Ras96/dotfiles
DOTFILES_REPO=git@github.com:Ras96/dotfiles.git

function ec () {
  echo -e "\e[36;1m$1\e[m"
}

if [ ! -d "$HOME/.ssh" ]; then
  ec "SSH configuration is required."
  exit 1
fi

ec "Installing basic commands..."
yes | sudo apt update
yes | sudo apt upgrade
yes | sudo add-apt-repository ppa:git-core/ppa
yes | sudo apt install \
  apt-transport-https \
  build-essential \
  ca-certificates \
  curl \
  file \
  git \
  gnupg \
  lsb-release \
  procps

if [ -d $DOTFILES_DIR ]; then
  ec "Updating dotfiles repository..."
  git -C $DOTFILES_DIR pull
else
  ec "Cloning dotfiles repository..."
  mkdir -p $DOTFILES_DIR
  git clone $DOTFILES_REPO $DOTFILES_DIR
fi

ec "Creating symboliclinks..."
source $DOTFILES_DIR/scripts/symboliclinks.sh

export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin
if !(type "brew" > /dev/null 2>&1); then
  ec "Installing brew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

ec "Installing brew packages..."
brew doctor
brew update
brew upgrade
brew bundle --global
brew bundle cleanup --global

ec "Installing asdf plugins..."
cat ~/.tool-versions | awk '{print "asdf plugin add " $1}' | sh

ec "Installing asdf packages..."
asdf install

# if !(type "rustup" > /dev/null 2>&1); then
#   ec "Installing rustup, rustc and cargo..."
#   /bin/bash -c "$(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs)"
# fi

ec "Installing VSCode extensions..."
for ext in $(cat $DOTFILES_DIR/.vscode-extensions.txt); do
  code --install-extension $ext
done

ec "Installing Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
sudo service docker start

ec "Setting up /etc ..."
sudo cp $DOTFILES_DIR/etc/cron.daily/cp_ssh /etc/cron.daily/cp_ssh
sudo cp $DOTFILES_DIR/etc/cron.daily/update_vscode_extensions_list /etc/cron.daily/update_vscode_extensions_list
sudo cp $DOTFILES_DIR/etc/wsl.conf /etc/wsl.conf
# sudo bash -c "echo "'nameserver 8.8.8.8'" > /etc/resolv.conf"
cat /etc/shells | grep fish || sudo bash -c "echo $(which fish) >> /etc/shells"

ec "[INFO] exec \"sudo visudo\" and add these lines:"
echo "ras     ALL=NOPASSWD: /usr/sbin/service"
echo "ras     ALL=NOPASSWD: /usr/sbin/hwclock"

ec "Changing default shell to fish..."
chsh -s $(which fish)
