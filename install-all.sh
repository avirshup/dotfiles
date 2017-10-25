#!/bin/bash

for file in installers/*.sh; do
    echocmd ./$file
done
