#!/bin/bash

for app in "google-chrome
       	sublime-text
	jet
	docker
	sourcetree 
	istat-menus
	avogadro
	pycharm-ce
	bettertouchtool
	mactex
	latexit
	texmaker
	sketch
	pinegrow-web-designer"; do
	
	echocmd brew cask install $app
done

