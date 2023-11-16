function wsl2_setup_sshagent -d 'Setup SSH agent for WSL2'
  if ! ss -a | grep -q $SSH_AUTH_SOCK >/dev/null 2>&1
    if test -e $SSH_AUTH_SOCK
      echo "removing previous socket..."
      rm -f $SSH_AUTH_SOCK
    end
    echo "Starting SSH-Agent relay..."
    set -x NPIPERELAY /mnt/c/Users/kira/scoop/shims/npiperelay.exe
    eval (setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"$NPIPERELAY -ei -s //./pipe/openssh-ssh-agent",nofork &) >/dev/null 2>&1
  end
end
