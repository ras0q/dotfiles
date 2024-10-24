function gf -d 'Repository search with ghq & fzf'
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
