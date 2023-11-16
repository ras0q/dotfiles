#!/bin/sh -eux

# Install Docker
sudo apt-get install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg;
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null;
sudo apt-get update -y;
sudo apt-get install -y docker-ce docker-ce-cli containerd.io;

# Install Docker Compose
mkdir -p ~/.docker/cli-plugins/;
curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose;
chmod +x ~/.docker/cli-plugins/docker-compose;
