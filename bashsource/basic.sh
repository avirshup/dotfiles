#always output human-readable sizes
alias df='df -h'

if [ "$(uname)" != 'Darwin' ]; then
    alias ls='ls -h --color=auto'
else
    alias top='top -o cpu'
    alias ls='ls -h'
    alias ssh='withtheme ssh'
    alias mosh='withtheme mosh'
fi
export CLICOLOR=1
alias du='du -h'
alias units='units -v'
stty erase ^H

alias ccat='pygmentize -f terminal'
export LSCOLORS="ExFxBxDxCxEgEdxbxgxcEd"
export GREP_OPTIONS='--color=auto'

exportenv () {
    # FROM https://stackoverflow.com/a/20909045/1958900
    if [ $# != 1 ] ; then
        echo 'USAGE: exportenv [env file]'
        return 1
    fi

    export $(cat $1 | grep -v '^#' | xargs)
}

