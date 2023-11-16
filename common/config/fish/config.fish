# setup background services for WSL2
wsl2_setup_sshagent

# abbreviations
fish_init_abbr

# starship
starship init fish | source

# zoxide
zoxide init --cmd cd --hook pwd fish | source

# 1password
source /home/ras/.config/op/plugins.sh
