# me
prepend-pathvar PATH $HOME/bin
prepend-pathvar PATH $HOME/.local/bin

# completion
if command -v brew &> /dev/null; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi
fi

export HISTSIZE=5000
export HISTFILESIZE=5000
export HISTCONTROL="$HISTCONTROL:ignoredups"
export HISTIGNORE="ls:ls -l:top"


# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if [ -f ${PYENV_ROOT}/bin/pyenv ]; then
   export PYENV_VIRTUALENV_DISABLE_PROMPT=1
   prepend-pathvar PATH ${PYENV_ROOT}/bin
   eval "$(pyenv init --path)"
   eval "$(pyenv virtualenv-init -)"
   eval "$(pyenv init -)"
else
  echo "pyenv not installed"
fi

# bashmarks
source ~/.local/bin/bashmarks.sh
append-pathvar MANPATH /usr/share/man:/usr/local/share/man
export EDITOR=vi
export SVN_EDITOR=vi


# CUDA
append-pathvar PATH /Developer/NVIDIA/CUDA-9.0/bin
append-pathvar DYLD_LIBRARY_PATH \
    /Developer/NVIDIA/CUDA-8.0/lib:/Developer/NVIDIA/CUDA-9.0/lib
