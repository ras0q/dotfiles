#!/bin/bash

cat ./wsl_symboliclink.csv | awk -F "," -v P=$PWD '{ printf("sudo ln -sfT %s/wsl/%s %s\n",P,$1,$2) }' | bash
