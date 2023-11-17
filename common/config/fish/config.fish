# $fish_user_paths
fish_add_path \
  ~/.local/share/aquaproj-aqua/bin \
  ~/.asdf/shims \
  ~/go/bin \
  ~/.rye/shims \
  ~/.volta/bin

# starship
starship init fish | source

# zoxide
zoxide init --cmd cd --hook pwd fish | source

# 1password
source /home/ras/.config/op/plugins.sh
