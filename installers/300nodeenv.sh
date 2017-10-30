#!/bin/bash

echocmd git clone https://github.com/nodenv/nodenv.git ~/.nodenv
git clone https://github.com/nodenv/node-build.git ~/.nodenv/plugins/node-build

cd ~/.nodenv && src/configure && make -C src || echo "Failed to compile nodenv bash autocomplete"

echo "Installed nodenv"

eval "$(nodenv init -)"
nodenv install 6.11.3
