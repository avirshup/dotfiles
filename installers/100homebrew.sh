#!/bin/bash

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo "Installed homebrew"

brew cask install xquartz

echocmd brew install "git 
hg
cmake
imagemagick
wget
vim
colordiff
mackup
the_silver_searcher"

