#!/usr/bin/env bash

if command -v pipx; then
    echo "pipx already installed"
else
    python3 -m pip install pipx
    python3 -m pipx ensurepath
fi

echocmd pipx install black[d]
echocmd pipx install mercurial
echocmd pipx inject mercurial mercurial_keyrings
echocmd pipx install jupyter-notebook
