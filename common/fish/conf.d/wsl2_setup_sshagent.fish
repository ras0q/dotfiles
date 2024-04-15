# setup 1Password SSH agent for WSL2

if ! string match -q "*microsoft*" (uname -r)
  exit 0
end

set -q SSH_AUTH_SOCK; or set -Ux SSH_AUTH_SOCK ~/.ssh/agent.sock
set -q NPIPERELAY_PATH; or begin
  # set -U (wslpath {{ path to npiperelay }})
  echo (set_color yellow)WARNING: \$NPIPERELAY_PATH is not set. 1Password SSH Agent will not be set up.(set_color normal)
  exit 0
end

if ! ss -a | grep -q $SSH_AUTH_SOCK >/dev/null 2>&1
  if test -e $SSH_AUTH_SOCK
    echo "removing previous socket..."
    rm -f $SSH_AUTH_SOCK
  end
  echo "Starting SSH-Agent relay..."
  eval (setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"$NPIPERELAY_PATH -ei -s //./pipe/openssh-ssh-agent",nofork &) >/dev/null 2>&1
end
