if status is-interactive
  fzf --fish | source
  git-wt --init fish | source
  zoxide init --cmd cd --hook pwd fish | source
end
