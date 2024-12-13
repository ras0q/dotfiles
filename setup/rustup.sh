#!/bin/bash -eux

# REF: https://www.rust-lang.org/tools/install
$__STEP__ "Install rustup"

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
