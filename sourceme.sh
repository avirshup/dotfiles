#!/bin/bash
# note: $DOTFILE_HOME must already be set

export PATH=${DOTFILE_HOME}/bin:${PATH}
for file in ${DOTFILE_HOME}/bashsource/*.sh; do
  echo "==== Sourcing: $file"
  source $file
done




