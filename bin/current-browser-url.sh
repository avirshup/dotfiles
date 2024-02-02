#!/usr/bin/env bash

osascript -e 'tell application "System Events" to get value of UI element 1 of combo box 1 of toolbar "Navigation" of first group of front window of application process "Firefox"'
