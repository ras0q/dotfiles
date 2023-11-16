#!/bin/sh -eux

# Install Homebrew
if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Setup Homebrew
PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
brew cleanup
brew update
brew upgrade
brew doctor

# Install packages from ~/.Brewfile
brew bundle --global --force
brew bundle cleanup --global --force
