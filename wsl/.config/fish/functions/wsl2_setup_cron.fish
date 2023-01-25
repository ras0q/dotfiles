function wsl2_setup_cron -d 'Setup cron for WSL2'
  if ! service cron status >/dev/null 2>&1
    echo "Firing up cron daemon..." >&2
    sudo service cron start >/dev/null 2>&1
    if service cron status >/dev/null 2>&1
      echo "cron now running." >&2
    else
      echo "cron failed to start!" >&2
    end
  end
end
