# setup background services for WSL2
wsl2_setup_cron
wsl2_setup_docker
wsl2_setup_sshagent

# fix problems for WSL2
wsl2_fix_interop

# abbreviations
fish_init_abbr

# asdf
source (brew --prefix asdf)/libexec/asdf.fish

# oh-my-posh
oh-my-posh init fish --strict --config ~/.omp-theme.json | source

# zoxide
zoxide init --cmd cd --hook pwd fish | source
