#!/usr/bin/env bash

defaults write -g NSFileViewer -string com.binarynights.ForkLift-3

defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add '{LSHandlerContentType="public.folder";LSHandlerRoleAll="com.binarynights.ForkLift-3";}'

# # To disable:
# defaults delete -g NSFileViewer
#
# defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add '{LSHandlerContentType="public.folder";LSHandlerRoleAll="com.apple.finder";}'
