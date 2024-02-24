# $fish_user_paths
fish_add_path \
  ~/.local/share/aquaproj-aqua/bin \
  ~/go/bin \
  ~/.rye/shims \
  ~/.volta/bin \
  ~/.cargo/bin \

# starship
starship init fish --print-full-init \
  | sed "s@(which starship)@(aqua which starship)@g" \
  | source

# zoxide
zoxide init --cmd cd --hook pwd fish | source
