#!/bin/bash

# pinegrow-web-designer -- doesn't appear to work currently \


for app in \
    google-chrome \
    sublime-text \
	jet \
	docker \
	sourcetree \
	istat-menus \
	avogadro \
	pycharm-ce \
	bettertouchtool \
	mactex \
	latexit \
	texmaker \
	sketch \
	slack \
	webstorm \
    slate \
	steermouse; do
	
	echocmd brew cask install $app
done

