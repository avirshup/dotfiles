#!/bin/bash
# note: $DOTFILE_HOME must already be set

_current_shell=$(sh -c 'ps -p $$ -o ppid=' | xargs ps -o comm= -p)
export CURRENT_SHELL=${_current_shell#-}

_extensions="sh"
case "${CURRENT_SHELL}" in 
  "bash")
  _extensions="$_extensions bash"
  ;;
  "zsh")
  _extensions="$_extensions zsh"
  ;;
esac

export PATH=${DOTFILE_HOME}/bin:${PATH}
echo "Loading: "
# "echo" hack for zsh/bash compatibility
for _ext in $(echo $_extensions); do
  for _f in ${DOTFILE_HOME}/shell_setup/*.${_ext}; do
    printf " $(basename $_f) ..."
    source $_f
    echo ✅
  done
done
echo ' done'
