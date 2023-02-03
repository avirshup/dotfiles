#!/usr/bin/env bash
# pass this to the `-a` argument of emacsclient
# to lazy-load emacs

set -euo pipefail

if command -v brew; then
    echo "Starting emacs daemon ..."
    set -x
    brew services run emacs-plus
    sleep 5
    emacsclient "$@"
else
    echo "Emacs lazy launcher only works with homebrew/emacs-plus"
    echo "You'll need to launch it your own damn self"
    exit 127
fi
