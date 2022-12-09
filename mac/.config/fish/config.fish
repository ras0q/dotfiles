# asdf
source (brew --prefix asdf)/libexec/asdf.fish

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
    ghq get git@github.com:ras0q/$reponame.git
    cd (ghq root)/github.com/ras0q/$reponame
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
oh-my-posh init fish --config ~/.omp-theme.json | source

status --is-interactive; and rbenv init - fish | source

# The next line updates PATH for the Google Cloud SDK.
if [ -f ~/google-cloud-sdk/path.fish.inc ]; . ~/google-cloud-sdk/path.fish.inc; end
