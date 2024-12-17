export PATH=/opt/homebrew/bin:$PATH

# If fish is installed, use it
# NOTE: This command should be at the end of this file
if [[ $- == *i* ]] && command -v fish >/dev/null 2>&1; then
  exec fish
fi

