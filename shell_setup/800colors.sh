#always output human-readable sizes
alias df='df -h'

if [ "$(uname)" != "Darwin" ]; then
    alias ls='ls -h --color=auto'
    export GREP_OPTIONS='--color=auto'

else
    alias top='top -o cpu'
    alias ls='ls -hG'
    alias ssh='withtheme ssh'
    alias mosh='withtheme mosh'
    alias grep='grep --color=auto'

fi
export CLICOLOR=1

alias du='du -h'
alias units='units -v'
alias tree='tree -C'

alias ccat='pygmentize -f terminal'

