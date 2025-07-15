# Interactive mode
[[ $- == *i* && $- != *c* && $- != *s* ]] || exit 0

# Execute fish if installed
FISH=$(mise which fish || which fish || exit 0)
[[ -z "$WARP_IS_LOCAL_SHELL_SESSION" ]] || exit 0

exec $FISH -l
