add_paths() {
  local new_paths=""
  for dir in "$@"; do
    if [ -d "$dir" ] && [[ ":$PATH:" != *":$dir:"* ]]; then
      new_paths="$dir:$new_paths"
    fi
  done

  if [ -n "$new_paths" ]; then
    export PATH="$new_paths$PATH"
  fi
}

add_paths \
  ~/go/bin \
  ~/.cargo/bin \
  ~/.deno/bin \
  /usr/local/cuda/bin \
  /opt/homebrew/bin \
  /opt/homebrew/opt/openjdk/bin \
  $CODE_BIN \
  $PWSH_BIN \

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
eval "$(mise activate bash)"
eval "$(mise completion bash)"

# fzf
eval "$(fzf --bash)"

# starship
eval "$(starship init bash --print-full-init)"

# zoxide
eval "$(zoxide init --cmd cd --hook pwd bash)"

# fnm
eval "$(fnm completions --shell bash)"
