prepend-pathvar() {
    varname=$1
    new=$2
    eval current=\$$varname  # gets current value as through indirect ref
    current=${new}${current:+:${current}}
    eval "$varname=$current"
    export ${varname}
}

append-pathvar() {
    varname=$1
    new=$2
    eval current=\$$varname 
    current=${current:+${current}:}${new}
    eval "$varname=$current"
    export ${varname}
}

stty erase ^H

prepend-pathvar PATH $HOME/bin
prepend-pathvar PATH $HOME/.local/bin

export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL="$HISTCONTROL:ignoredups"
export HISTIGNORE="ls:ls -l:top"