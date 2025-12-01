# zmodload zsh/zprof

local kernel=$(uname -s)
local kernel_version=$(uname -r)
local function is_mingw() { [[ "$kernel" == *MINGW* ]] }
local function is_wsl2() { [[ "$kernel_version" == *microsoft* ]] }

local function command_exists() { command -v "$1" >/dev/null 2>&1 }

HISTFILE=~/.zsh_history
HISTORY_IGNORE="(cd|pwd|1[sal])"
HISTSIZE=10000
SAVEHIST=10000
setopt extended_history
setopt hist_allow_clobber
setopt hist_fcntl_lock
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_functions
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt inc_append_history_time

# fzf-tab (configure → compinit → load)
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:git-reset:*' sort false

# compinit
autoload -Uz compinit
if [ "$(date +'%j')" != "$(date -r ~/.zcompdump +'%j' 2>/dev/null)" ]; then
  if [[ ! -f ~/.zcompdump ]]; then
    touch ~/.zcompdump
  fi
  compinit
else
  compinit -C
fi

# Functions
cdp() {
  read -r DIR_PATH
  [[ -n "$DIR_PATH" ]] && cd "$DIR_PATH" || exit 1
}

git-worktree-add-interactive() {
  local branch=$(git branch --format='%(refname:short)' | fzf --preview 'git log --oneline -20 --color=always {}')
  [[ -z "$branch" ]] && return 1

  local repo_path="$(git rev-parse --show-toplevel)+${branch//\//_}"
  [[ -d "$repo_path" ]] && echo "warning: $repo_path already exists" && cd "${repo_path}"

  git worktree add "${repo_path}" "${branch}" || return 1
  cd "${repo_path}"
}

# Plugin manager
[[ -d ~/.antidote ]] || git clone --depth 1 https://github.com/mattmc3/antidote.git ~/.antidote
source ~/.antidote/antidote.zsh
antidote load

# Syntax highlight theme
mkdir -p ~/.zsh
local shl_catppuccin=~/.zsh/catppuccin_latte-zsh-syntax-highlighting.zsh
[[ -f $shl_catppuccin ]] || curl -o $shl_catppuccin https://raw.githubusercontent.com/catppuccin/zsh-syntax-highlighting/refs/heads/main/themes/catppuccin_latte-zsh-syntax-highlighting.zsh
source $shl_catppuccin

# Abbreviations
export ABBR_SET_EXPANSION_CURSOR=1
export ABBR_GET_AVAILABLE_ABBREVIATION=1
export ABBR_LOG_AVAILABLE_ABBREVIATION=1

# Completions
zsh-defer eval "$(gh completion -s zsh)"
if command_exists op; then
  zsh-defer eval "$(op completion zsh)"
fi

# WSL2
if is_wsl2; then
  # setup 1Password SSH agent for WSL2
  if command_exists npiperelay; then
    if ! ss -a | grep -q "$SSH_AUTH_SOCK" >/dev/null 2>&1; then
      if [[ -e "$SSH_AUTH_SOCK" ]]; then
        echo "removing previous socket..."
        rm -f "$SSH_AUTH_SOCK"
      fi
      echo "Starting SSH-Agent relay..."
      (setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"npiperelay -ei -s //./pipe/openssh-ssh-agent",nofork &) >/dev/null 2>&1
    fi
  else
    echo "Install npiperelay (https://github.com/jstarks/npiperelay) in Windows, then symlink to ~/.local/bin/npiperelay"
  fi

  function wsl2_fix_time() {
    sudo ntpdate ntp.nict.jp
  }
fi

# mise
function load-mise() {
  eval "$(mise activate zsh)"
  eval "$(mise completion zsh)"
}
if ! is_mingw; then
  zsh-defer load-mise
fi

function mise-which() { is_mingw && echo "$1" || mise which "$1"; }

# fzf
eval "$($(mise-which fzf) --zsh)"

# starship
eval "$($(mise-which starship) init zsh --print-full-init)"

# zoxide
eval "$($(mise-which zoxide) init --cmd cd --hook pwd zsh)"

# gomi
if ! is_mingw && command_exists gomi; then
  alias rm=gomi
  # zsh-defer gomi --prune=3m & > /dev/null
fi

# cursor
# eval "$(code --locate-shell-integration-path zsh)"

# Zellij
# if ! is_mingw && command_exists zellij; then
#   eval "$(zellij setup --generate-auto-start zsh)"
# fi

# NOTE: Redirecting to /dev/null creates a file named NUL.
is_mingw && rm -rf ./NUL

# zprof
