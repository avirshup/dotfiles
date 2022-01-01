# completion
if [[ "$CURRENT_SHELL" = "-bash" ]]; then
    if command -v brew &> /dev/null; then
        if [ -f $(brew --prefix)/etc/bash_completion ]; then
            . $(brew --prefix)/etc/bash_completion
        fi
    fi
elif [[ "$CURRENT_SHELL" = "-zsh" ]]; then
    if type brew &>/dev/null; then
        FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
        autoload -Uz compinit
        compinit
    fi
fi



# # nodenv
# export NODENV_ROOT="$HOME/.nodenv"
# if [ -f ${NODENV_ROOT}/bin/nodenv ]; then
#    prepend-pathvar PATH ${NODENV_ROOT}/bin
#    eval "$(nodenv init -)"
# else
# 	echo "nodenv not installed"
# fi


# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if [ -f ${PYENV_ROOT}/bin/pyenv ]; then
   prepend-pathvar PATH ${PYENV_ROOT}/bin
   eval "$(pyenv init --path)"
   eval "$(pyenv virtualenv-init -)"
   eval "$(pyenv init -)"
else
  echo "pyenv not installed"
fi


# bashmarks (works with zsh too)
source ~/.local/bin/bashmarks.sh



append-pathvar MANPATH /usr/share/man:/usr/local/share/man
export EDITOR=vi
export SVN_EDITOR=vi

# optional prefixes
for pfx in /usr/local/cuda /opt/vulkan; do
    if [ -d "$pfx/bin" ]; then
        append-pathvar PATH "$pfx/bin"
    fi
    if [ -d "$pfx/lib" ]; then
        append-pathvar DYLD_LIBRARY_PATH "$pfx/lib" 
    fi
done
