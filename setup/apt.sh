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

$__STEP__ "Install Go (using PPA if needed)"

source /etc/os-release
# Ubuntu 24.04以前はGo toolchainを使えないGoが入るのでppaを追加する
if [[ $(echo "$VERSION_ID < 24.04" | bc) = 1 ]]; then
  sudo apt-add-repository -y ppa:longsleep/golang-backports
  sudo apt-get update
fi
sudo apt-get install -y golang-go

$__STEP__ "Install Git using PPA"

sudo apt-add-repository -y ppa:git-core/ppa
sudo apt-get update
sudo apt-get install -y git

$__STEP__ "Install fish using PPA"

sudo apt-add-repository -y ppa:fish-shell/release-3
sudo apt-get update
sudo apt-get install -y fish

# REF: https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
$__STEP__ "Install Docker and Compose"

sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
