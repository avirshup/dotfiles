#!/bin/bash

set -e

if command -v pyenv; then
    echo "pyenv already installed"
    exit 0
fi

echocmd git clone https://github.com/pyenv/pyenv.git ~/.pyenv
echocmd git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
git clone https://github.com/pyenv/pyenv-which-ext.git ~/.pyenv/plugins/pyenv-which-ext
echo "Installed pyenv to ~/.pyenv"

echo installing miniconda environment ...
echocmd pyenv install miniconda3-latest
echocmd pyenv global miniconda3-latest
echocmd conda upgrade conda
echocmd conda upgrade -n base python
