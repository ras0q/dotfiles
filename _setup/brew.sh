#!/bin/bash -eux

# REF: https://brew.sh/
echo "Install Homebrew"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
source ~/.zshenv

echo "Install Homebrew packages"

brew upgrade
brew doctor
brew bundle --global --force
brew bundle cleanup --global --force
