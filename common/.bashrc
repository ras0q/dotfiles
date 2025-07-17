# Interactive mode
[[ $- == *i* && $- != *c* && $- != *s* ]] || exit 0

# Execute zsh if installed
if [[ "$(uname -s)" =~ "MINGW" ]] && command -v zsh > /dev/null 2>&1; then
  exec zsh
fi

# Execute fish if installed
# FISH=$(mise which fish -E linux || which fish || echo "")
# [[ -z "$WARP_IS_LOCAL_SHELL_SESSION" ]] || exit 0
# [[ -n "$FISH" ]] && exec $FISH

