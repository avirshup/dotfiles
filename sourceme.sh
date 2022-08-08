#!/bin/bash
# note: $DOTFILE_HOME must already be set


if [[ -n "$ZSH_NAME" ]]; then
    CURRENT_SHELL=zsh
elif [[ -n "$BASH" ]]; then
    CURRENT_SHELL=bash
else
    echo "WARNING: not sure what sort of shell this is. Falling back to 'sh'"
    CURRENT_SHELL=sh
fi
export CURRENT_SHELL 

_extensions="sh"
case "${CURRENT_SHELL#-}" in
  "bash")
  _extensions="$_extensions bash"
  ;;
"zsh")
  _extensions="$_extensions zsh"
  ;;
esac

export PATH=${DOTFILE_HOME}/bin:${PATH}
echo "Loading ${CURRENT_SHELL} environment: "
# "echo" hack for zsh/bash compatibility
for _ext in $(echo $_extensions); do
  for _f in ${DOTFILE_HOME}/shell_setup/*.${_ext}; do
    printf " $(basename $_f) ..."
    source $_f
    echo ✅
  done
done
echo ' done'
