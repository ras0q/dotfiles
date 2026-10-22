[ -r "$HOME/.profile" ] && . "$HOME/.profile"

if [[ $- == *i* && $- != *s* && -z ${BASH_EXECUTION_STRING+x} ]] && command -v fish >/dev/null 2>&1; then
  if shopt -q login_shell; then
    exec fish --login
  fi
  exec fish
fi
