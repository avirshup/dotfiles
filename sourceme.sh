#!/bin/bash
# note: $DOTFILE_HOME must already be set

export PATH=${DOTFILE_HOME}/bin:${PATH}
echo "Loading: "
for file in ${DOTFILE_HOME}/bashsource/*.sh; do
  printf " $(basename $file) ..."
  source $file
  echo ✅
done
echo ' done'




