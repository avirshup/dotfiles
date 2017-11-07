# nodenv
export NODENV_ROOT="$HOME/.nodenv"
if [ -f ${NODENV_ROOT}/bin/nodenv ]; then
   export PATH="${NODENV_ROOT}/bin:$PATH"
   eval "$(nodenv init -)"
else
	echo "nodenv not installed"
fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
if [ -f ${PYENV_ROOT}/bin/pyenv ]; then
   export PATH="${PYENV_ROOT}/bin:$PATH"
   eval "$(pyenv init -)"
   eval "$(pyenv virtualenv-init -)"
else
  echo "pyenv not installed"
fi


# bashmarks
source ~/.local/bin/bashmarks.sh

export PATH=$HOME/bin:/usr/local/bin:$PATH
export MANPATH=$MANPATH:/usr/man:/usr/local/man

export EDITOR=vi
export SVN_EDITOR=vi

