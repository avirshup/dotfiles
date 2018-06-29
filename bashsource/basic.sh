#always output human-readable sizes
alias df='df -h'
alias ls='ls -h --color=auto'
alias du='du -h'
alias units='units -v'
if [ "$(uname)" == "Darwin" ]; then 
   alias top='top -o cpu'
fi
stty erase ^H

alias ccat='pygmentize -f terminal'
alias ssh='withtheme ssh'
alias mosh='withtheme mosh'
export CLICOLOR=1
export LSCOLORS="ExFxBxDxCxEgEdxbxgxcEd"
export GREP_OPTIONS='--color=auto'


