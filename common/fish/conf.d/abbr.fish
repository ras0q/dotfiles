# git
abbr -a ga 'git add -A && git commit'
abbr -a gc 'git commit'
abbr -a gs 'git switch'
abbr -a gst 'git status'
abbr -a gp 'git push'
abbr -a gpp 'git pull --rebase && git bprune'

# docker
abbr -a d docker
abbr -a dc 'docker compose'

# ls (eza)
abbr -a la 'eza -al'
abbr -a ll 'eza -l'
abbr -a ls eza

# others
abbr -a bd 'brew bundle dump --global --tap --formula -f'
abbr -a c 'code .'
abbr -a grm 'rm -i $GOPATH/bin/(ls $GOPATH/bin | fzf)'
abbr -a gg 'ghq get'
abbr -a h 'hx .'
abbr -a pp pnpm
abbr -a sc systemctl
abbr -a zj zellij
