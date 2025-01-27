# mise
mise activate fish --shims | source
mise activate fish | source
mise completion fish | source

# fzf
fzf --fish | source

# starship
starship init fish --print-full-init | source

# zoxide
zoxide init --cmd cd --hook pwd fish | source

# fnm
fnm env --use-on-cd --shell fish | source
fnm completions --shell fish | source

# Zellij
if not set -q ZELLIJ
    if set -q ZELLIJ_AUTO_ATTACH
        zellij attach -c

        if set -q ZELLIJ_AUTO_EXIT
            kill $fish_pid
        end
    else
        set_color green
        echo "You can start Zellij automatically by setting \$ZELLIJ_AUTO_ATTACH."
        set_color normal
    end
end
