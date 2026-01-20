# zmodload zsh/zprof

function _command_exists() { command -v "$1" >/dev/null 2>&1 }
function _load_plugin() {
  local plugin_path="${XDG_CONFIG_HOME:-$HOME/.config}/zsh/plugins/$1/$1.plugin.zsh"
  [[ -f "$plugin_path" ]] && source "$plugin_path"
}

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

_load_plugin zsh-defer
_load_plugin zsh-completions

# compinit
autoload -Uz compinit
_zcompdump="${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/.zcompdump-${HOST}-${ZSH_VERSION}"
mkdir -p "${_zcompdump:h}"
if [[ -f "${_zcompdump}" && $(( $(date +%s) - $(stat -c %Y "${_zcompdump}") )) -lt 86400 ]]; then
  zsh-defer compinit -C -d "${_zcompdump}"
else
  echo "Generating ${_zcompdump} ..."
  zsh-defer compinit -d "${_zcompdump}"
fi

# Zsh plugins
zsh-defer _load_plugin fzf-tab # load after compinit, before other plugins
zsh-defer _load_plugin zsh-autosuggestions
bindkey '^y' autosuggest-accept
zsh-defer _load_plugin zsh-abbr
zsh-defer _load_plugin ni
zsh-defer _load_plugin cute
zsh-defer _load_plugin translate-shell

# Functions
cdp() {
  read -r DIR_PATH
  [[ -n "$DIR_PATH" ]] && cd "$DIR_PATH" || return 1
}

git-worktree-add-interactive() {
  local branch=$(git branch --format='%(refname:short)' | fzf --preview 'git log --oneline -20 --color=always {}')
  if [[ -z "$branch" ]]; then
    return 1
  fi

  local repo_base_path="$(git rev-parse --show-toplevel)"
  repo_base_path=${repo_base_path%+*}
  local repo_path="${repo_base_path}+${branch//\//_}"
  if [[ -d "$repo_path" ]]; then
    echo "warning: ${repo_path} already exists" >&2
    echo "${repo_path}"
    return 0
  fi

  git worktree add -q "${repo_path}" "${branch}" || return 1
  echo "${repo_path}"
}

# Syntax highlight theme
mkdir -p ~/.zsh
local shl_catppuccin=~/.zsh/catppuccin_latte-zsh-syntax-highlighting.zsh
[[ -f $shl_catppuccin ]] || curl -o $shl_catppuccin https://raw.githubusercontent.com/catppuccin/zsh-syntax-highlighting/refs/heads/main/themes/catppuccin_latte-zsh-syntax-highlighting.zsh
source $shl_catppuccin

# Abbreviations
export ABBR_SET_EXPANSION_CURSOR=1
export ABBR_GET_AVAILABLE_ABBREVIATION=1
export ABBR_LOG_AVAILABLE_ABBREVIATION=1

# WSL2
if _is_wsl2; then
  # setup 1Password SSH agent for WSL2
  if command -v npiperelay >/dev/null 2>&1; then
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
if ! _is_mingw; then
  zsh-defer load-mise
fi

function mise-which() { _is_mingw && echo "$1" || mise which "$1"; }

# fzf
eval "$($(mise-which fzf) --zsh)"

# starship
eval "$($(mise-which starship) init zsh --print-full-init)"

# zoxide
eval "$($(mise-which zoxide) init --cmd cd --hook pwd zsh)"

# gomi
if ! _is_mingw && _command_exists gomi; then
  alias rm=gomi
  # zsh-defer gomi --prune=3m & > /dev/null
fi

# Completions
zsh-defer eval "$($(mise-which gh) completion -s zsh)"
zsh-defer eval "$($(mise-which op) completion zsh)"

# NOTE: Redirecting to /dev/null creates a file named NUL.
_is_mingw && rm -rf ./NUL

# zprof
