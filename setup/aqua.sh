#!/bin/bash -eux

# REF: https://aquaproj.github.io/docs/products/aqua-installer#shell-script
$__STEP__ "Install aqua"

curl -sSfL -O https://raw.githubusercontent.com/aquaproj/aqua-installer/v3.0.1/aqua-installer
echo "fb4b3b7d026e5aba1fc478c268e8fbd653e01404c8a8c6284fdba88ae62eda6a  aqua-installer" | sha256sum -c
chmod +x aqua-installer
./aqua-installer
rm ./aqua-installer

$__STEP__ "Install aqua packages"

~/.local/share/aquaproj-aqua/bin/aqua install --all --only-link

