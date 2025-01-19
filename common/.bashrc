add_paths() {
  local new_paths=""
  for dir in "$@"; do
    if [ -d "$dir" ] && [[ ":$PATH:" != *":$dir:"* ]]; then
      new_paths="$dir:$new_paths"
    fi
  done

  if [ -n "$new_paths" ]; then
    export PATH="$new_paths$PATH"
  fi
}

add_paths \
  /usr/local/cuda/bin \
  /opt/homebrew/bin

# If fish is installed, use it
# NOTE: This command should be at the end of this file
if [[ $- == *i* ]] && command -v fish >/dev/null 2>&1; then
  exec fish
fi

