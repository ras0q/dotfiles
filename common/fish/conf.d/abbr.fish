# git
abbr -a g 'git status'
abbr -a ga 'git add -A && git commit'
abbr -a gc 'git commit'
abbr -a gd 'git diff'
abbr -a gl 'git log --oneline'
abbr -a gp 'git push'
abbr -a gs 'git switch'
abbr -a gss 'git status'
abbr -a gt 'git stash'
abbr -a gu 'git pull'

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
abbr -a cdf 'cd (fd -td | fzf || echo $PWD)'
abbr -a e '/mnt/c/Windows/explorer.exe .'
abbr -a ge gemini
abbr -a gep 'gemini -p'
abbr -a grm 'rm -i $GOPATH/bin/(ls $GOPATH/bin | fzf)'
abbr -a gg 'ghq get'
abbr -a h 'hx .'
abbr -a n 'nvim .'
abbr -a pp pnpm
abbr -a sc systemctl
abbr -a zj zellij
