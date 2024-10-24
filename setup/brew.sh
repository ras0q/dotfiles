#!/bin/bash

# REF: https://brew.sh/
$__STEP__ "Install Homebrew"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

$__STEP__ "Install Homebrew packages"

brew upgrade
brew doctor
brew bundle --global --force
brew bundle cleanup --global --force
