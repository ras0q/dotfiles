# zmodload zsh/zprof

if [[ "${ZSH_EXEC_FISH:-}" == "1" && -x "$(command -v fish)" && $- == *i* ]]; then
    exec fish
fi

function _is_wsl2() {
  [[ -n "${WSL_INTEROP:-}" || "$(uname -r)" == *microsoft* ]]
}
function _is_mingw() {
  [[ "$(uname -s)" == MINGW* ]]
}

if _is_wsl2; then
  alias ssh="/mnt/c/Windows/System32/OpenSSH/ssh.exe"
  alias ssh-add="/mnt/c/Windows/System32/OpenSSH/ssh-add.exe"
  function wsl2_fix_time() {
    sudo ntpdate ntp.nict.jp
  }
fi

alias cr='cd "$(echo ~/ghq/$(ghq list | fzf))"'
alias n='nvim'
alias ls='eza'

HISTORY_IGNORE="(cd|pwd|1[sal])"
HISTSIZE=10000
SAVEHIST=10000
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt inc_append_history_time

# compinit
autoload -Uz compinit
mkdir -p "${XDG_CACHE_HOME:-${HOME}/.cache}/zsh"
compinit -d "${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/.zcompdump-${HOST}-${ZSH_VERSION}"

# mise
function load-mise() {
  eval "$(mise activate zsh)"
  eval "$(mise completion zsh)"
}
if ! _is_mingw; then
  load-mise
fi

function mise-which() { _is_mingw && echo "$1" || mise which "$1"; }

# fzf
eval "$($(mise-which fzf) --zsh)"

# git-wt
eval "$(git-wt --init zsh)"

# starship
eval "$($(mise-which starship) init zsh --print-full-init)"

# zoxide
eval "$($(mise-which zoxide) init --cmd cd --hook pwd zsh)"

# NOTE: Redirecting to /dev/null creates a file named NUL.
_is_mingw && rm -rf ./NUL

# zprof
