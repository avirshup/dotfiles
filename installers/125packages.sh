#!/bin/bash


brew cask install xquartz

for pkg in "git 
hg
cmake
imagemagick
wget
vim
colordiff
mackup
the_silver_searcher"; do
	echocmd brew install $pkg
done

