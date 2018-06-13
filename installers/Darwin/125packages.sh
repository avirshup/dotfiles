#!/bin/bash


brew cask install xquartz

for pkg in \
    git \
    hg \
    cmake \
    imagemagick \
    wget \
    vim \
    colordiff \
    mackup \
    jq \
    dbus \
    the_silver_searcher; do

	echocmd brew install $pkg
	
done

brew services start dbus

