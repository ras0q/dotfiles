#!/bin/bash
set -euo pipefail

can_use_sudo=false
install_fonts=false
for arg in "$@"; do
  case "$arg" in
    --sudo) can_use_sudo=true ;;
    --install-fonts) install_fonts=true ;;
    -h|--help)
      printf 'Usage: %s [--sudo] [--install-fonts]\n' "$0"
      exit 0
      ;;
    *) printf 'Unknown option: %s\n' "$arg" >&2; exit 2 ;;
  esac
done

cd "$(dirname "${BASH_SOURCE[0]}")"

case "$(uname -s)" in
  MINGW*|MSYS*|CYGWIN*)
    if "$can_use_sudo"; then
      bash -e _setup/winget.sh
    fi
    ;;
esac

if "$can_use_sudo"; then
  bash -e _setup/mise.sh --sudo
else
  bash -e _setup/mise.sh
fi

if "$install_fonts"; then
  bash -e _setup/font.sh
fi
