if status is-interactive
    # mise
    mise completion fish | source

    # fzf
    fzf --fish | source

    # starship
    set -U fish_color_command 0087ff
    starship init fish --print-full-init | source

    # zoxide
    zoxide init --cmd cd --hook pwd fish | source

    # Zellij
    # eval (zellij setup --generate-auto-start fish | string collect)
end
