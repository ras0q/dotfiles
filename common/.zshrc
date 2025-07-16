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
  if type npiperelay.exe; then
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
