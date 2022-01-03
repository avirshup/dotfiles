#!/usr/bin/env bash

set -e

if command -v nvm; then
  echo "nvm already installed"
  exit 0
fi

cd /tmp
echocmd wget \
  https://raw.githubusercontent.com/nvm-sh/nvm/4856407d2691d2135420f25d00acdb6d9b85ae3d/install.sh \
  -O install-nvm.sh

fhash=$(md5 -q install-nvm.sh)

[ $"fhash" == 6eed9840d2e814d2e4c9e1c91c2f3b81 ] || (
  echo "ERROR INSTALLING NVM: installer hash check failed"
  exit 1
)

echocmd bash install-nvm.sh
