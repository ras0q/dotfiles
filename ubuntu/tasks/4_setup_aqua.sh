#!/bin/sh -eux

BRANCH="v2.2.0"
curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/$BRANCH/aqua-installer | bash

export PATH="${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin:$PATH"

aqua --version
aqua install
