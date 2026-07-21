[ -f "$HOME/.env" ] && source "$HOME/.env"

[ -n "$COURSIER_BIN_DIR" ] || export COURSIER_BIN_DIR="$HOME/.local/share/coursier/bin"
[ -n "$DOTFILES" ] || export DOTFILES="$HOME/ghq/github.com/ras0q/dotfiles"
[ -n "$EDITOR" ] || export EDITOR="nvim"
[ -n "$GOPATH" ] || export GOPATH="$HOME/go"
[ -n "$GOBIN" ] || export GOBIN="$HOME/go/bin"
[ -n "$LANG" ] || export LANG="POSIX"
[ -n "$MISE_ENV" ] || export MISE_ENV="$(uname -s | tr '[:upper:]' '[:lower:]')"
[ -n "$OBSIDIAN_VAULT_PATH" ] || export OBSIDIAN_VAULT_PATH="$HOME/ghq/github.com/ras0q/obsidian_private"
[ -n "$XGD_CONFIG_HOME" ] || export XGD_CONFIG_HOME="$HOME/.config"

case "$(uname -s)" in
  Darwin)
    export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    ;;
  *MINGW*)
    [ -n "$MSYS" ] || export MSYS="winsymlinks:nativestrict"
    ;;
esac

append_path() {
  case ":$PATH:" in
    *":$1:"*) ;;
    *)
      [ -d "$1" ] && PATH="$1${PATH:+:$PATH}"
      ;;
  esac
}

append_path "$COURSIER_BIN_DIR"
append_path "$HOME/.local/bin"
append_path "$HOME/.local/share/mise/shims"
append_path "$HOME/.local/share/nvim/mason/bin"
append_path "$HOME/.rd/bin"
append_path "$HOME/.cargo/bin"
append_path "$HOME/.deno/bin"
append_path "$HOME/go/bin"
append_path "/usr/local/cuda/bin"
append_path "/opt/homebrew/bin"
append_path "/opt/homebrew/opt/openjdk/bin"

if [ -n "$WINDOWS_HOME" ]; then
  append_path "$WINDOWS_HOME/AppData/Local/Programs/Microsoft VS Code/bin"
  append_path "$WINDOWS_HOME/AppData/Local/Programs/cursor/resources/app/bin"
  append_path "$WINDOWS_HOME/AppData/Local/Microsoft/WindowsApps"
  append_path "$WINDOWS_HOME/AppData/Local/Microsoft/WinGet/Links"
  append_path "/c/Program Files/PowerShell/7"
  append_path "/mnt/c/Program Files/PowerShell/7"
fi

export PATH
