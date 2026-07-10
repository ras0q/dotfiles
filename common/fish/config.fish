if status is-interactive
  # mise
  mise activate fish | source
  mise completion fish | source

  fzf --fish | source
  git-wt --init fish | source
  zoxide init --cmd cd --hook pwd fish | source

  if type -q pndr
      pndr init fish --hook-prompt | source
  end
end
