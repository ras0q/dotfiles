#!/bin/bash -eux

$__STEP__ "Install mise"

curl https://mise.run | sh
~/.local/bin/mise install
if [[ "$(uname)" == "Linux" || "$(uname)" == "Darwin" ]]; then
  ~/.local/bin/mise install aqua:eza-community/eza
  ~/.local/bin/mise install aqua:fish-shell/fish-shell
fi
