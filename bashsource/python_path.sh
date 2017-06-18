export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

export PYTHONPATH=$HOME/python_pkg

# my interpreters
alias py2="pyenv shell 2.7.13"
alias py3="pyenv shell 3.6.1"
alias pyconda3="pyenv shell miniconda3-4.1.11"
alias pyconda2="pyenv shell miniconda2-4.1.11"


function import(){
	cmd="import $@"
    ipython -i -c "${cmd}"
}


function from(){
        cmd="from $@"
    ipython -i -c "${cmd}"
}

