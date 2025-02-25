#!/bin/bash -eu

DENO_INSTALL=/tmp/.deno

curl -fsSL https://deno.land/install.sh | sh -s -- -y --no-modify-path

PATH=$DENO_INSTALL/bin:$PATH
./install.ts $@
rm -r $DENO_INSTALL
