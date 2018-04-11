#always output human-readable sizes
alias df='df -h'
alias ls='ls -h'
alias du='du -h'
alias units='units -v'
stty erase ^H

alias ccat='pygmentize -f terminal'
alias ssh='withtheme ssh'
alias mosh='withtheme mosh'
export CLICOLOR=1
alias top='top -o cpu'
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

