add_paths() {
  local new_paths=()
  for dir in "$@"; do
    if [[ -d "$dir" && ":$PATH:" != *":$dir:"* ]]; then
      new_paths+=("$dir")
    fi
  done

  if [[ ${#new_paths[@]} -gt 0 ]]; then
    export PATH="$(IFS=:; echo "${new_paths[*]}"):${PATH}"
  fi
}

windows_user=${WINDOWS_USER:-$(whoami)}
add_paths \
  ~/.local/bin \
  ~/.local/share/mise/shims \
  ~/.rd/bin \
  ~/.cargo/bin \
  ~/.deno/bin \
  ~/go/bin \
  /usr/local/cuda/bin \
  /opt/homebrew/bin \
  /opt/homebrew/opt/openjdk/bin

if [[ -n "$WINDOWS_HOME" ]]; then
  add_paths \
    $WINDOWS_HOME/AppData/Local/Programs/Microsoft\ VS\ Code/bin \
    $WINDOWS_HOME/AppData/Local/Programs/cursor/resources/app/bin \
    $WINDOWS_HOME/AppData/Local/Microsoft/WindowsApps \
    $WINDOWS_HOME/AppData/Local/Microsoft/WinGet/Links \
    /c/Program\ Files/PowerShell/7 \
    /mnt/c/Program\ Files/PowerShell/7
fi

[[ -z "$EDITOR" ]] && export EDITOR="hx"
[[ -z "$GOPATH" ]] && export GOPATH="$HOME/go"
[[ -z "$GOBIN" ]] && export GOBIN="$HOME/go/bin"
[[ -z "$LANG" ]] && export LANG=POSIX
[[ -z "$DOTFILES" ]] && export DOTFILES="$HOME/ghq/github.com/ras0q/dotfiles"

if [[ $(uname -r) == *microsoft* ]]; then
  [[ -z "$SSH_AUTH_SOCK" ]] && export SSH_AUTH_SOCK="$HOME/.ssh/agent.sock"
fi

[[ -f ~/.env ]] && source ~/.env
