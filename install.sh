#!/bin/bash -eux

export DENO_INSTALL=/tmp/.deno

curl -fsSL https://deno.land/install.sh | sh -s -- -y --no-modify-path

$DENO_INSTALL/bin/deno run -A ./install.ts $@
rm -r $DENO_INSTALL
