#!/bin/bash -eux

$__STEP__ "Install apt packages"

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y \
    bc \
    curl \
    ca-certificates \
    make \
    gcc \
    socat \
    wget

$__STEP__ "Add apt PPAs (Git, Fish)"

sudo apt-add-repository -y ppa:git-core/ppa
sudo apt-add-repository -y ppa:fish-shell/release-3

# REF: https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
$__STEP__ "Add an apt repository for Docker and Compose"

sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

$__STEP__ "Install additional packages"

sudo apt-get update
sudo apt-get install -y \
  git \
  fish \
  docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
