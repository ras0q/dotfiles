# Interactive mode
[[ $- == *i* && $- != *c* && $- != *s* ]] || return 0

# Execute zsh if installed
if [[ "$(uname -s)" =~ "MINGW" ]] && command -v zsh > /dev/null 2>&1; then
  exec zsh
fi

[[ -f ~/.zshenv ]] && source ~/.zshenv

# Execute fish if installed
# FISH=$(mise which fish -E linux || which fish || echo "")
# [[ -z "$WARP_IS_LOCAL_SHELL_SESSION" ]] || exit 0
# [[ -n "$FISH" ]] && exec $FISH
