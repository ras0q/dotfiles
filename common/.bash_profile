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
  ~/.cargo/bin \
  ~/.deno/bin \
  ~/go/bin \
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

# NOTE: this command should be at the end
[ -f ~/.bashrc ] && source ~/.bashrc
