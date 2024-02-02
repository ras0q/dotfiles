#!/bin/sh -eux

# rustup
rm -f /tmp/rustup.sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > /tmp/rustup.sh
sh /tmp/rustup.sh -y --no-modify-path
rm -f /tmp/rustup.sh
