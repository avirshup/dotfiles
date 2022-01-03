#!/bin/bash

xcode-select --install

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
    bash \
    bash-completion \
    the_silver_searcher \
    zsh \
    trash; do

    echocmd brew install $pkg

done

brew services start dbus
