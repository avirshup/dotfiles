#!/bin/bash

for app in google-chrome sublime-text jet docker istat-menus avogadro pycharm-ce; do
	echocmd brew cask install $app
done
