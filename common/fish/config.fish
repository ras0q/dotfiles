# $fish_user_paths
fish_add_path \
    ~/.local/share/aquaproj-aqua/bin \
    ~/go/bin \
    ~/.volta/bin \
    ~/.cargo/bin \
    ~/.deno/bin \
    /opt/homebrew/bin \
    /opt/homebrew/opt/openjdk/bin
set -q CODE_BIN; and fish_add_path $CODE_BIN
set -q PWSH_BIN; and fish_add_path $PWSH_BIN

# fzf
fzf --fish | source

# starship
starship init fish --print-full-init \
    | sed "s@(which starship)@(aqua which starship)@g" \
    | source

# zoxide
zoxide init --cmd cd --hook pwd fish | source

# fnm
fnm completions --shell fish | source

# Zellij
set -q ZELLIJ_AUTOSTART; and not set -q ZELLIJ; and zellij
