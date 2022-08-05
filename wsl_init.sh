#!/bin/bash

# if ~/.ssh doesn't exist, exit with error
[ -d "$HOME/.ssh" ] || { echo "SSH configuration is required."; exit 1; }

echo "Installing basic commands..."
sudo apt update -y
sudo apt upgrade -y
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt install git

echo "Creating symboliclinks..."
cat ./wsl_symboliclink.csv | awk -F "," -v P=$PWD '{ printf("sudo ln -sfT %s/wsl/%s %s\n",P,$1,$2) }' | bash

export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin
if !(type "brew" > /dev/null 2>&1); then
  echo "Installing brew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Installing brew packages..."
brew doctor
brew update
brew upgrade
brew bundle --global
brew bundle cleanup --global

echo "Installing asdf plugins..."
cat ~/.tool-versions | awk '{print "asdf plugin add " $1}' | bash

echo "Installing asdf packages..."
asdf install

echo "Installing Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
sudo service docker start

echo "Setting up /etc ..."
cat /etc/shells | grep fish || sudo bash -c "echo $(which fish) >> /etc/shells"

echo "[INFO] execho \"sudo visudo\" and add these lines:"
echo "ras     ALL=NOPASSWD: /usr/sbin/service"
echo "ras     ALL=NOPASSWD: /usr/sbin/hwclock"

echo "Changing default shell to fish..."
chsh -s $(which fish)
