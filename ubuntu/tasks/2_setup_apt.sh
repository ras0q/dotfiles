#!/bin/sh -eux

sudo apt update -y
sudo apt upgrade -y

sudo apt install -y \
  git \
  fish \
  make \
  gcc \
  socat # for 1Password SSH
