#!/bin/bash -eux

$__STEP__ "Install mise"

curl https://mise.run | sh
~/.local/bin/mise install
