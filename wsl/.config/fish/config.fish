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

# ssh-agent
if ! ss -a | grep -q $SSH_AUTH_SOCK >/dev/null 2>&1
   if test -S $SSH_AUTH_SOCK
       echo "removing previous socket..."
       rm -f $SSH_AUTH_SOCK
   end
   echo "Starting SSH-Agent relay..."
   set -x NPIPERELAY /mnt/c/Users/kira/scoop/shims/npiperelay.exe
   eval (socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"$NPIPERELAY -ei -s //./pipe/openssh-ssh-agent",nofork &) >/dev/null 2>&1
end

# asdf
source (brew --prefix asdf)/libexec/asdf.fish

# oh-my-posh
oh-my-posh init fish --strict --config ~/.omp-theme.json | source

# zoxide
zoxide init --cmd cd --hook pwd fish | source

# fix interop
fix_wsl2_interop
