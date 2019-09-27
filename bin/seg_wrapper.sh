#!/bin/bash
# Examines segfaults
# USAGE: seg_wrapper.sh [command] [args ...]
# Some mods, originally from https://serverfault.com/a/61676/397136

set -m
$(which gdb > /dev/null) || { echo "GDB must be installed"; exit 1; }

ulimit -c unlimited
"$@" &
PID="${!}"
fg 1
if [[ $? -eq 139 ]]; then
    gdb -q $1 /cores/core.${PID} -x ~/backtrace
fi
