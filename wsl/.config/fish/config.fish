# setup background services for WSL2
wsl2_setup_cron
wsl2_setup_docker
wsl2_setup_sshagent

# asdf
source (brew --prefix asdf)/libexec/asdf.fish

# oh-my-posh
oh-my-posh init fish --strict --config ~/.omp-theme.json | source

# zoxide
zoxide init --cmd cd --hook pwd fish | source

# fix interop
fix_wsl2_interop
