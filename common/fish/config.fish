# mise
mise activate fish --shims | source

if status is-interactive
    # Zellij
    eval (zellij setup --generate-auto-start fish | string collect)

    # mise
    mise activate fish | source
    mise completion fish | source

    # fzf
    fzf --fish | source

    # starship
    starship init fish --print-full-init | source

    # zoxide
    zoxide init --cmd cd --hook pwd fish | source
end
