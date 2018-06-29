#!/bin/bash
# This needs to run at the root of the dotfiles repo

export PATH=${PWD}/bin:${PATH}
for file in installers/*.sh installers/$(uname)/*.sh; do
    echocmd ./$file
done
