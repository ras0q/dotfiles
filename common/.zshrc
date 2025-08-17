# zmodload zsh/zprof

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

# Plugin manager
[[ -d ~/.antidote ]] || git clone --depth 1 https://github.com/mattmc3/antidote.git ~/.antidote
source ~/.antidote/antidote.zsh
antidote load

# compinit
autoload -Uz compinit
local now=$(date +"%s")
[[ -f ~/.zcompdump ]] && local updated=$(date -r ~/.zcompdump +"%s") || local updated=0
local threshold=$((60 * 60 * 24))
if [ $((${now} - ${updated})) -gt ${threshold} ]; then
  zsh-defer compinit
else
  # if there are new functions can be omitted by giving the option -C.
  zsh-defer compinit -C
fi

# Syntax highlight theme
mkdir -p ~/.zsh
local shl_catppuccin=~/.zsh/catppuccin_latte-zsh-syntax-highlighting.zsh
[[ -f $shl_catppuccin ]] || curl -o $shl_catppuccin https://raw.githubusercontent.com/catppuccin/zsh-syntax-highlighting/refs/heads/main/themes/catppuccin_latte-zsh-syntax-highlighting.zsh
source $shl_catppuccin

# Abbreviations
export ABBR_SET_EXPANSION_CURSOR=1
export ABBR_GET_AVAILABLE_ABBREVIATION=1
export ABBR_LOG_AVAILABLE_ABBREVIATION=1

# fzf-tab
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:git-reset:*' sort false

# Completions
zsh-defer eval "$(gh completion -s zsh)"

# WSL2
if [[ $(uname -r) == *microsoft* ]]; then
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
if [[ ! "$(uname -s)" =~ "MINGW" ]]; then
  zsh-defer load-mise
fi

# fzf
eval "$($(mise which fzf) --zsh)"

# starship
eval "$($(mise which starship) init zsh --print-full-init)"

# zoxide
eval "$($(mise which zoxide) init --cmd cd --hook pwd zsh)"

# gomi
if command -v gomi >/dev/null 2>&1; then
  alias rm=gomi
  gomi --prune=3m > /dev/null
fi

# cursor
# eval "$(code --locate-shell-integration-path zsh)"

# Zellij
# eval "$(zellij setup --generate-auto-start zsh)"

# zprof
