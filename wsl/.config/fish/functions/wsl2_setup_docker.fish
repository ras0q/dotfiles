function wsl2_setup_docker -d 'Setup docker for WSL2'
  if ! service docker status >/dev/null 2>&1
    echo "Firing up docker daemon..." >&2
    sudo service docker start >/dev/null 2>&1
    if service docker status >/dev/null 2>&1
      echo "docker now running." >&2
    else
      echo "docker failed to start!" >&2
    end
  end
end
