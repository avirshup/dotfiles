#!/bin/bash
# note: $DOTFILE_HOME must already be set

export PATH=${PWD}/bin:${PATH}
for file in ${DOTFILE_HOME}/bashsource/*.sh; do
  echo "==== Sourcing: $file"
  source $file
done




