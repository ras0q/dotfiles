#!/bin/bash

$__STEP__ "Install pacman packages"

pacman -Syu --noconfirm
pacman -S --noconfirm \
    curl \
    git \
    fish \
    vim
