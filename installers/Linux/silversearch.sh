#!/bin/sh

if command -v apt-get; then
    apt-get install -y silversearcher-ag 
elif command -v yum; then
    yum install -y epel-release.noarch
    yum install -y the_silver_searcher
else;
    echo "Could not determine this system's package manager"
fi
