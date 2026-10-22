# Import the shared POSIX environment without losing spaces or newlines in values.
if test -r "$HOME/.profile"
  for entry in (sh -c '. "$HOME/.profile" && env -0' | string split0)
    set -l pair (string split -m 1 '=' -- "$entry")
    if string match -rq '^[a-zA-Z_][a-zA-Z0-9_]*$' -- "$pair[1]"; and not contains -- "$pair[1]" PWD SHLVL _ status pipestatus version fish_pid history hostname
      set -gx "$pair[1]" "$pair[2]"
    end
  end
end

if status is-interactive
  if set -q WSL_DISTRO_NAME; or set -q WSL_INTEROP; or string match -qi '*microsoft*' -- (uname -r)
    alias ssh '/mnt/c/Windows/System32/OpenSSH/ssh.exe'
    alias ssh-add '/mnt/c/Windows/System32/OpenSSH/ssh-add.exe'
  end

  # mise
  mise activate fish | source
  mise completion fish | source

  fzf --fish | source
  git-wt --init fish | source
  zoxide init --cmd cd --hook pwd fish | source
  starship init fish | source
  functions --erase fish_right_prompt
end
