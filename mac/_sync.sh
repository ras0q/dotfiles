#!/bin/bash

[ $(basename $(pwd)) != "mac" ] && echo "Run this script from the \"mac\" directory." && exit 1

cat ./_symboliclink.csv | awk -F "," -v P=$PWD '{ printf("if [ -L %s ]; then sudo unlink %s; fi && sudo ln -sf %s/mac/%s %s\n",$2,$2,P,$1,$2) }' | bash
