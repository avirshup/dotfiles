#always output human-readable sizes
alias df='df -h'

if [ "$(uname)" != 'Darwin' ]; then
    alias ls='ls -hG --color=auto'
    export GREP_OPTIONS='--color=auto'

else
    alias top='top -o cpu'
    alias ls='ls -h'
    alias ssh='withtheme ssh'
    alias mosh='withtheme mosh'
    alias grep='grep --color=auto'
fi
export CLICOLOR=1

alias du='du -h'
alias units='units -v'
alias grep='grep --color=auto'
alias tree='tree -C'

if [ "$(uname)" == "Darwin" ]; then 
   alias top='top -o cpu'
fi
stty erase ^H

alias ccat='pygmentize -f terminal'
export LSCOLORS="ExFxBxDxCxEgEdxbxgxcEd"

exportenv () {
    # FROM https://stackoverflow.com/a/20909045/1958900
    if [ $# != 1 ] ; then
        echo 'USAGE: exportenv [env file]'
        return 1
    fi

    export $(cat $1 | grep -v '^#' | xargs)
}
