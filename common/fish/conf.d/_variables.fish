# Common universal variables
# This file do not force users to rewrite all variables in fish_variables.

set -q AQUA_GLOBAL_CONFIG; or set -Ux AQUA_GLOBAL_CONFIG ~/.config/aquaproj-aqua/aqua.yaml
set -q EDITOR; or set -Ux EDITOR hx
set -q GOPATH; or set -Ux GOPATH ~/go
set -q LANG; or set -Ux LANG POSIX
