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
eval "$(sheldon source)"

# Abbreviations
export ABBR_SET_EXPANSION_CURSOR=1
export ABBR_GET_AVAILABLE_ABBREVIATION=1
export ABBR_LOG_AVAILABLE_ABBREVIATION=1

# mise
eval "$(mise activate zsh)"
eval "$(mise completion zsh)"

# fzf
eval "$(fzf --zsh)"

# starship
eval "$(starship init zsh --print-full-init)"

# zoxide
eval "$(zoxide init --cmd cd --hook pwd zsh)"

# setup 1Password SSH agent for WSL2
if [[ $(uname -r) == *microsoft* ]]; then
  if command -v npiperelay.exe >/dev/null 2>&1; then
    if ! ss -a | grep -q "$SSH_AUTH_SOCK" >/dev/null 2>&1; then
      if [[ -e "$SSH_AUTH_SOCK" ]]; then
        echo "removing previous socket..."
        rm -f "$SSH_AUTH_SOCK"
      fi
      echo "Starting SSH-Agent relay..."
      (setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork &) >/dev/null 2>&1
    fi
  else
    echo "Install npiperelay (https://github.com/jstarks/npiperelay) in Windows, then symlink to ~/.local/bin/npiperelay"
  fi
fi

# cursor
# eval "$(code --locate-shell-integration-path zsh)"

# Zellij
# eval "$(zellij setup --generate-auto-start zsh)"
