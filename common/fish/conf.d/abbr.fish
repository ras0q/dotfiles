# git
abbr -a ga 'git add -A && git commit'
abbr -a gc 'git commit'
abbr -a gs 'git switch'
abbr -a gst 'git status'
abbr -a gp 'git push'
abbr -a gpp 'git pull && git bprune'

# docker
abbr -a d docker
abbr -a dc 'docker compose'

# ls (eza)
abbr -a la 'eza -al'
abbr -a ll 'eza -l'
abbr -a ls eza

# others
abbr -a aqi 'aqua g -i && aqua upc -a -deep -prune && aqua i -a'
abbr -a bd 'brew bundle dump --global --tap --formula -f'
abbr -a c 'code .'
abbr -a grm 'rm -i $GOPATH/bin/(ls $GOPATH/bin | fzf)'
abbr -a gg 'ghq get'
abbr -a h 'hx .'
abbr -a n nvim
abbr -a nn 'nvim .'
abbr -a pp pnpm
abbr -a sc systemctl
