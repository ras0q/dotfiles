#!/bin/bash

[ $(basename $(pwd)) != "wsl" ] && echo "Run this script from the \"wsl\" directory." && exit 1

cat ./_symboliclink.csv | awk -F "," -v P=$PWD '{ printf("if [ -L %s ]; then sudo unlink %s; fi && sudo ln -sfT %s/wsl/%s %s\n",$2,$2,P,$1,$2) }' | bash
