#always output human-readable sizes
alias df='df -h'
alias du='du -h'
alias units='units -v'
stty erase ^H

alias ccat='pygmentize -f terminal'
alias ssh='withtheme ssh'
alias mosh='withtheme mosh'
export CLICOLOR=1
alias top='top -o cpu'
export LSCOLORS="ExFxBxDxCxEgEdxbxgxcEd"


if [ "$(uname)" == 'Darwin' ]; then
    export GREP_OPTIONS='--color=auto'
    alias ls='ls -hG'
else
    alias ls='ls -h --color=auto'
    alias grep='grep --color=auto'
fi

