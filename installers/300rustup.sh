#!/usr/bin/env bash


if command -v rustup; then
    echo "Rustup already installed"
    exit 0
fi

# TODO: stop running scripts from the internet
curl https://sh.rustup.rs -sSf | sh