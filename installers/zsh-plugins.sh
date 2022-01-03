#!/usr/bin/env bash

set -e

echo "Installing OMZ"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echocmd git clone --depth=1 \
    https://github.com/romkatv/powerlevel10k.git \
    ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echocmd git clone --depth 1 \
    https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "TODO:"
echo "  You need to comment out all the unwanted command aliases in ~/.oh-my-zsh/common"
