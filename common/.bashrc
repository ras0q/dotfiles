add_paths() {
  local new_paths=""
  for dir in "$@"; do
    if [ -d "$dir" ] && [[ ":$PATH:" != *":$dir:"* ]]; then
      new_paths="$new_paths:$dir"
    fi
  done

  if [ -n "$new_paths" ]; then
    export PATH="$new_paths:$PATH"
  fi
}

windows_user=${WINDOWS_USER:-$(whoami)}
add_paths \
  ~/.local/bin \
  ~/go/bin \
  ~/.cargo/bin \
  ~/.deno/bin \
  /usr/local/cuda/bin \
  /opt/homebrew/bin \
  /opt/homebrew/opt/openjdk/bin \
  /c/Users/$windows_user/AppData/Local/Programs/Microsoft\ VS\ Code/bin \
  /c/Users/$windows_user/AppData/Local/Microsoft/WindowsApps \
  /c/Users/$windows_user/AppData/Local/Microsoft/WinGet/Links \
  /c/Program\ Files/PowerShell/7

[[ -z "$EDITOR" ]] && export EDITOR="hx"
[[ -z "$GOPATH" ]] && export GOPATH="$HOME/go"
[[ -z "$LANG" ]] && export LANG POSIX

# If fish is installed, use it
# NOTE: This command should be at the end of this file
if [[ $- == *i* ]] && command -v fish >/dev/null 2>&1; then
  exec fish
  exit 0
fi

# Fallback

# mise
eval "$(mise activate bash --shims)"
