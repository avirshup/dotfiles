#always output human-readable sizes
alias df='df -h'
alias ls='ls -h'
alias du='du -h'
alias units='units -v'
stty erase ^H

#Always do X11 forwarding
alias ccat='pygmentize -f terminal'
alias ssh='ssh -Y'
export CLICOLOR=1
alias top='top -o cpu'
alias diff=colordiff
export LSCOLORS="ExFxBxDxCxEgEdxbxgxcEd"
export GREP_OPTIONS='--color=auto'
alias emacs=/Applications/Emacs.app/Contents/MacOS/Emacs
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

alias clean-repo="git clean -x -d -i"

function grep-repo(){
git grep $@ $(git rev-list --all)
}

