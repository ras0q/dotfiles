# mise (call first!)
mise hook-env -s fish | source
mise completion fish | source

# fzf
fzf --fish | source

# starship
starship init fish --print-full-init | source

# zoxide
zoxide init --cmd cd --hook pwd fish | source

# fnm
fnm completions --shell fish | source

# Zellij
if not set -q ZELLIJ; and set -q ZELLIJ_AUTO_ATTACH
    zellij attach -c

    if set -q ZELLIJ_AUTO_EXIT
        kill $fish_pid
    end
end
