#!/usr/bin/env bash
#
# Modified from the idea at:
# https://osxdaily.com/2011/08/25/disable-reopen-windows-when-logging-back-in-in-mac-os-x-lion-completely/
#
#
# To enable (not compatible with other login hooks I guess):
# `defaults write com.apple.loginwindow LoginHook $PATH_TO_THIS_FILE`
#
# To disable:
# `defaults delete com.apple.loginwindow LoginHook`

rm $HOME/Library/Preferences/ByHost/com.apple.loginwindow.* || echo "No login sessions to clean."
