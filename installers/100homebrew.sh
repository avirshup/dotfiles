#!/bin/bash

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo "Installed homebrew"

brew cask install xquartz

echocmd brew install git hg
echocmd brew install cmake
echocmd brew install imagemagick
echocmd brew install wget vim colordiff
