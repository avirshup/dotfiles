#!/bin/bash

echocmd git clone https://github.com/nodenv/nodenv.git ~/.nodenv
cd ~/.nodenv && src/configure && make -C src || echo "Failed to compile nodenv bash autocomplete"

echo "Installed nodenv"
