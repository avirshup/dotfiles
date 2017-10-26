# nodenv
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# bashmarks
source ~/.local/bin/bashmarks.sh

export PATH=$HOME/bin:/usr/local/bin:$PATH
export MANPATH=$MANPATH:/usr/man:/usr/local/man

export AMBERHOME=/Users/aaronvirshup/installs/amber14
export DYLD_LIBRARY_PATH=/Developer/NVIDIA/CUDA-7.0/lib:$HOME/lib
export EDITOR=vi
export SVN_EDITOR=vi

