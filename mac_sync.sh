#!/bin/bash

cat ./mac_symboliclink.csv | awk -F "," -v P=$PWD '{ printf("if [ -L %s ]; then sudo unlink %s; fi && sudo ln -sf %s/mac/%s %s\n",$2,$2,P,$1,$2) }' | bash
