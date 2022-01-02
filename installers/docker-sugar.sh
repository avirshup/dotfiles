#!/usr/bin/env bash

set -e

if command -v dps; then
    echo "Docker cli sugar already installed"
    exit 0
fi

parentdir=~/bin/

mkdir -p "$parentdir"
cd "$parentdir"
git clone https://github.com/avirshup/docker-cli-sugar.git docker-cli-sugar

echo "export PATH=\$PATH:$parentdir/docker-cli-sugar" >> ~/.bash_profile