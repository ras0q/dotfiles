function wsl2_fix_interop
  for i in $(pstree -np -s $fish_pid | grep -o -E '[0-9]+')
    if test -e /run/WSL/{$i}_interop
      export WSL_INTEROP=/run/WSL/{$i}_interop
    end
  end
end
