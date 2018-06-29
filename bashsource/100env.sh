# me
prepend-pathvar PATH $HOME/bin
prepend-pathvar PATH $HOME/.local/bin

# nodenv
export NODENV_ROOT="$HOME/.nodenv"
if [ -f ${NODENV_ROOT}/bin/nodenv ]; then
   prepend-pathvar PATH ${NODENV_ROOT}/bin
   eval "$(nodenv init -)"
else
	echo "nodenv not installed"
fi


# pyenv
export PYENV_ROOT="$HOME/.pyenv"
if [ -f ${PYENV_ROOT}/bin/pyenv ]; then
   prepend-pathvar PATH ${PYENV_ROOT}/bin
   eval "$(pyenv init -)"
   eval "$(pyenv virtualenv-init -)"
else
  echo "pyenv not installed"
fi


# bashmarks
source ~/.local/bin/bashmarks.sh
append-pathvar MANPATH /usr/man:/usr/local/man
export EDITOR=vi
export SVN_EDITOR=vi


# CUDA
append-pathvar PATH /Developer/NVIDIA/CUDA-9.0/bin
append-pathvar DYLD_LIBRARY_PATH \
    /Developer/NVIDIA/CUDA-8.0/lib:/Developer/NVIDIA/CUDA-9.0/lib
