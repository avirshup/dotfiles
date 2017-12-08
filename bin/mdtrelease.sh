#!/bin/bash


if [ -n "$1" ]; then
version=0.7.3
else
version="$1"
fi

echo "Starting Jupyter on host port 8890"

docker run \
   -v /var/run/docker.sock:/var/run/docker.sock \
       -v $HOME/.moldesign:/root/.moldesign \
   -p 8890:8888 -it \
   docker.io/autodesk/moldesign:moldesign_notebook-$version

