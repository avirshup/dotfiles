#!/usr/bin/env bash

if command -v pipx; then
    echo "pipx already installed"
else
    python3 -m pip install pipx
    python3 -m pipx ensurepath
fi

