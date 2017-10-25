export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export PYTHONPATH=$HOME/python_pkg

# my interpreters
alias py2="pyenv shell 2.7.13"
alias py3="pyenv shell 3.6.1"
alias pyconda3="pyenv shell py36"
alias pyconda35="pyenv shell miniconda3-4.1.11"
alias pyconda2="pyenv shell miniconda2-4.1.11"


function import(){
	cmd="import $@"
    ipython -i -c "${cmd}"
}


function from(){
        cmd="from $@"
    ipython -i -c "${cmd}"
}


function nb(){
   if [ "$#" -eq 0 ]; then
     echo "USAGE: nb [notebook file] [jupyter notebook arguments ...]"
     exit 1
   fi
   file=$1
   if [ "$file" == "--temp" ]; then
      dir=$(mktemp -d)
      echo "Created temp directory at $dir"
      file=$dir/tempNB.ipynb
   fi
   if [ ! -e $file ]; then
     dir=$(dirname $file)
     name=$(basename $file .ipynb).ipynb
     file=$dir/$name
     echocmd cp ${DOTFILE_HOME}/blank_notebook.ipynb $file
   fi
   shift
   echocmd jupyter notebook $file $@
}
