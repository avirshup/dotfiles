
unset PROMPT_COMMAND
PROMPT_ANSI='33m'
export PS1='\[\e]2;\h:${PWD}\a\e[${PROMPT_ANSI}\][\u@\h \W]\$\[\e[m\] '
