#!/usr/bin/env bash

ln -s "${DOTFILE_HOME}/etc/amv.blackd.plist" ~/Library/LaunchAgents
launchctl load -w ~/Library/LaunchAgents/amv.blackd.plist