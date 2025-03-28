# If fish is installed, use it
# NOTE: This command should be at the end of this file
if [[ $- == *i* ]] && \
  [[ -z "$WARP_IS_LOCAL_SHELL_SESSION" ]] && \
  command -v fish >/dev/null 2>&1; then
  exec fish
  exit 0
fi
