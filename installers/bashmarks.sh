#!/bin/bash

cd /tmp
echocmd git clone git://github.com/huyng/bashmarks.git
cd bashmarks
echocmd make install
echo "Installed bashmarks"
