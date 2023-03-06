# abbreviations
fish_init_abbr

# asdf
source (brew --prefix asdf)/libexec/asdf.fish

# oh-my-posh
oh-my-posh init fish --config ~/.omp-theme.json | source

# zoxide
zoxide init --cmd cd --hook pwd fish | source

# renv
status --is-interactive; and rbenv init - fish | source

# volta
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

# updates PATH for the Google Cloud SDK.
source ~/google-cloud-sdk/path.fish.inc
