# $fish_user_paths
fish_add_path \
  ~/.local/share/aquaproj-aqua/bin \
  ~/go/bin \
  ~/.rye/shims \
  ~/.volta/bin \
  ~/.cargo/bin \
  /opt/homebrew/bin
set -q CODE_BIN; and fish_add_path $CODE_BIN
set -q PWSH_BIN; and fish_add_path $PWSH_BIN

# fzf
fzf --fish | source

# starship
starship init fish --print-full-init \
  | sed "s@(which starship)@(aqua which starship)@g" \
  | source

# zoxide
zoxide init --cmd cd --hook pwd fish | source
