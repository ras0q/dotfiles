# Common universal variables
# This file do not force users to rewrite all variables in fish_variables.

set -q EDITOR; or set -Ux EDITOR hx
set -q GOPATH; or set -Ux GOPATH ~/go
set -q LANG; or set -Ux LANG POSIX

fish_add_path \
    ~/go/bin \
    ~/.cargo/bin \
    ~/.deno/bin \
    /opt/homebrew/bin \
    /opt/homebrew/opt/openjdk/bin
set -q CODE_BIN; and fish_add_path $CODE_BIN
set -q PWSH_BIN; and fish_add_path $PWSH_BIN

mise activate fish --shims | source
mise activate fish | source
