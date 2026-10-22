if [[ -o interactive && -z ${ZSH_EXECUTION_STRING+x} ]] && command -v fish >/dev/null 2>&1; then
  if [[ -o login ]]; then
    exec fish --login
  fi
  exec fish
fi
