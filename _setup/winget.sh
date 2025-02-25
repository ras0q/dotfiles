#!/bin/bash -eux

$__STEP__ "Install WinGet (if not exists)"

if ! command -v winget >/dev/null 2>&1; then
    bundle=winget.msixbundle
    curl -o $bundle https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
    pwsh -c Add-AppxPackage -Path $bundle
    rm $bundle
fi

$__STEP__ "Install WinGet Packages"

winget import \
    --accept-source-agreements \
    --accept-package-agreements \
    --no-upgrade \
    --disable-interactivity \
    ./win/winget.jsonc
