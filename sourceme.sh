#!/bin/bash
# note: $DOTFILE_HOME must already be set

export PATH=${DOTFILE_HOME}/bin:${PATH}
printf "Setting up environment "
for file in ${DOTFILE_HOME}/bashsource/*.sh; do
  # echo "==== Sourcing: $file"
  printf '.'
  source $file
done
echo ' done'




