PATH=$PATH:~/.local/bin
# add Go Path for VSCode
PATH=$PATH:~/.local/share/aquaproj-aqua/bin

# If fish is installed, use it
# NOTE: This command should be at the end of this file
if command -v fish >/dev/null 2>&1; then
  exec fish
fi
complete -C /home/ras/go/bin/xc xc
