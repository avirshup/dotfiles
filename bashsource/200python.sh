append-pathvar PYTHONPATH $HOME/python_pkg

# my interpreters
alias py2="pyenv shell miniconda-latest"
alias py3="pyenv shell miniconda3-latest"


function import(){
	cmd="import $@"
    ipython -i -c "${cmd}"
}


function from(){
        cmd="from $@"
    ipython -i -c "${cmd}"
}

