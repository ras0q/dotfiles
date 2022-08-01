# asdf
source (brew --prefix asdf)/libexec/asdf.fish

# if which swiftenv > /dev/null; status --is-interactive; and source (swiftenv init -|psub); end

# cron
if ! service cron status >/dev/null 2>&1
    echo "Firing up cron daemon..." >&2
    sudo service cron start >/dev/null 2>&1
    if service cron status >/dev/null 2>&1
        echo "cron now running." >&2
    else
        echo "cron failed to start!" >&2
    end
end

# docker
if ! service docker status >/dev/null 2>&1
    echo "Firing up docker daemon..." >&2
    sudo service docker start >/dev/null 2>&1
    if service docker status >/dev/null 2>&1
        echo "docker now running." >&2
    else
        echo "docker failed to start!" >&2
    end
end

# functions
# ---
# fish key bindings
function fish_user_key_bindings
    bind \cg gf_open
end

# gh create & ghq get
function ghcr
    set -x reponame $argv[1]
    gh repo create $reponame --private
    ghq get git@github.com:Ras96/$reponame.git
    cd (ghq root)/github.com/Ras96/$reponame
    git branch -M main
end

# ghq + fzf
function gf -d 'Repository search'
    ghq list | fzf | read select
    if test -n "$select"
        cd (ghq root)/$select
        echo "$select"
        commandline -f repaint
    else
        echo "No repository selected."
        return 1
    end
end

# ghq + fzf + editor
function gf_open -d 'Repository search and open in editor'
    gf && echo "Opening" (basename (pwd)) "in $EDITOR" && $EDITOR .
end

# oh-my-posh
oh-my-posh init fish --config ~/.night-owl.my.omp.json | source

# bun
set -Ux BUN_INSTALL "/home/ras/.bun"
fish_add_path "/home/ras/.bun/bin"

