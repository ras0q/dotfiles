#!/bin/bash -eux

# REF: https://aquaproj.github.io/docs/products/aqua-installer#shell-script
$__STEP__ "Install aqua"

installer_path=/tmp/aqua-installer
curl -sSfL -o $installer_path https://raw.githubusercontent.com/aquaproj/aqua-installer/v3.0.1/aqua-installer
echo "fb4b3b7d026e5aba1fc478c268e8fbd653e01404c8a8c6284fdba88ae62eda6a  $installer_path" | sha256sum -c
bash $installer_path
rm $installer_path

$__STEP__ "Install aqua packages"

~/.local/share/aquaproj-aqua/bin/aqua install --all --only-link

