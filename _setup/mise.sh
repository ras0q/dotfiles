#!/bin/bash
set -euo pipefail

echo "Install mise"

if ! command -v mise >/dev/null 2>&1; then
  curl -fsSL https://mise.run | sh
fi
MISE_PATH=$(command -v mise || echo ~/.local/bin/mise)

case "$(uname)" in
  Linux) platform=linux ;;
  Darwin) platform=macos ;;
  *) platform=windows ;;
esac
bootstrap_args=(bootstrap)
if [[ "${1:-}" != "--sudo" ]]; then
  bootstrap_args+=(--skip packages,files)
fi
if [[ -n "${WSL_DISTRO_NAME:-}" ]]; then
  bootstrap_args+=(--env wsl)
fi

"$MISE_PATH" trust ./mise.toml
"$MISE_PATH" trust "./mise.$platform.toml"
if [[ -n "${WSL_DISTRO_NAME:-}" ]]; then
  "$MISE_PATH" trust ./mise.wsl.toml
fi
"$MISE_PATH" dot apply ~/.config/mise
"$MISE_PATH" "${bootstrap_args[@]}"
