add_paths() {
  local new_paths=""
  for dir in "$@"; do
    if [ -d "$dir" ] && [[ ":$PATH:" != *":$dir:"* ]]; then
      new_paths="$dir:$new_paths"
    fi
  done

  if [ -n "$new_paths" ]; then
    export PATH="$new_paths:$PATH"
  fi
}

windows_user=${WINDOWS_USER:-$(whoami)}
add_paths \
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
if [[ "$OSTYPE" == "msys"* ]]; then
  # https://github.com/jdx/mise/issues/4011
  add_paths ~/AppData/Local/mise/shims
  command_not_found_handle() {
    [[ $1 == *.* || $1 == */* ]] && { echo "$1: command not found"; return 127; }
    local name=$1; shift
    for ext in bat cmd; do
      command -v "$name.$ext" &>/dev/null && exec "$name.$ext" "$@"
    done
    echo "$name: command not found"; return 127
  }
else
  eval "$(mise activate bash --shims)"
fi

if [[ $- == *i* ]]
  eval "$(mise activate bash)"
  eval "$(mise completion bash)"

  # fzf
  eval "$(fzf --bash)"

  # starship
  eval "$(starship init bash --print-full-init)"

  # # zoxide
  # eval "$(zoxide init --cmd cd --hook pwd bash)"
fi
