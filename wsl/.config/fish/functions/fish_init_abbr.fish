function fish_init_abbr -d 'Initialize fish abbreviations'
  # git
  abbr -a ga 'git add . && git commit'
  abbr -a gc 'git commit'
  abbr -a gs 'git switch'
  abbr -a gp 'git push'
  abbr -a gpp 'git pull && git bprune'

  # docker
  abbr -a d 'docker'
  abbr -a dc 'docker compose'

  # ls (exa)
  abbr -a la 'exa -al'
  abbr -a ll 'exa -l'
  abbr -a ls 'exa'

  # others
  abbr -a grm 'rm -i $GOPATH/bin/(ls $GOPATH/bin | fzf)'
  abbr -a gg 'ghq get'
  abbr -a sc 'systemctl'
end
