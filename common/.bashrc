# Interactive mode
[[ $- == *i* && $- != *c* && $- != *s* ]] || exit 0

# Execute fish if installed
FISH=$(mise which fish -E linux || which fish || echo "")
[[ -z "$WARP_IS_LOCAL_SHELL_SESSION" ]] || exit 0
[[ -n "$FISH" ]] && exec $FISH

