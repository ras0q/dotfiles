# Common universal variables
# This file do not force users to rewrite all variables in fish_variables.

set -q fish_user_paths; or set -Ux fish_user_paths \
  ~/.local/share/aquaproj-aqua/bin \
  ~/.asdf/shims \
  ~/go/bin \
  ~/.rye/shims \
  ~/.volta/bin

set -q AQUA_GLOBAL_CONFIG; or set -Ux AQUA_GLOBAL_CONFIG ~/.config/aquaproj-aqua/aqua.yaml
set -q EDITOR; or set -Ux EDITOR nvim
set -q GOPATH; or set -Ux GOPATH ~/go
set -q LANG; or set -Ux LANG POSIX
set -q SSH_AUTH_SOCK; or set -Ux SSH_AUTH_SOCK ~/.ssh/agent.sock
