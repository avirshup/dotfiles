#!/bin/bash

echocmd /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo "Installed homebrew"

echocmd brew install git
echocmd brew install cmake
echocmd brew install imagemagick
