#!/bin/bash -eux

$__STEP__ "Install pacman packages"

curl https://mise.run | sh
mise install
