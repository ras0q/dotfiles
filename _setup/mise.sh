#!/bin/bash -eux

echo "Install mise"

if ! command -v mise >/dev/null 2>&1; then
  curl https://mise.run | sh
  source ~/.bash_profile
fi
MISE_PATH=$(command -v mise || echo ~/.local/bin/mise)

$MISE_PATH install
if [[ "$(uname)" == "Linux" || "$(uname)" == "Darwin" ]]; then
  $MISE_PATH install --path ~/.config/mise/config.linux.toml
fi
