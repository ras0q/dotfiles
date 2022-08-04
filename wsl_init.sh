#!/bin/bash

function ec () { echo -e "\e[36;1m$1\e[m"; }

# if ~/.ssh doesn't exist, exit with error
[ -d "$HOME/.ssh" ] || { ec "SSH configuration is required."; exit 1; }

ec "Installing basic commands..."
sudo apt update -y
sudo apt upgrade -y
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt install git

ec "Creating symboliclinks..."
cat ./wsl_symboliclink.csv | awk -F "," -v P=$PWD '{ printf("sudo ln -sf %s/wsl/%s %s\n",P,$1,$2) }' | bash

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
cat ~/.tool-versions | awk '{print "asdf plugin add " $1}' | bash

ec "Installing asdf packages..."
asdf install

ec "Installing Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
sudo service docker start

ec "Setting up /etc ..."
cat /etc/shells | grep fish || sudo bash -c "echo $(which fish) >> /etc/shells"

ec "[INFO] exec \"sudo visudo\" and add these lines:"
echo "ras     ALL=NOPASSWD: /usr/sbin/service"
echo "ras     ALL=NOPASSWD: /usr/sbin/hwclock"

ec "Changing default shell to fish..."
chsh -s $(which fish)
