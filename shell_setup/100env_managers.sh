# completion
if [[ "$CURRENT_SHELL" = "-bash" ]]; then
    if command -v brew &>/dev/null; then
        if [ -f $(brew --prefix)/etc/bash_completion ]; then
            . $(brew --prefix)/etc/bash_completion
        fi
    fi

    # This loads nvm (for bash, anyway. For ZSH, use the zsh-nvm plugin)
    export NVM_DIR="$HOME/.nvm"
    if [[ -d "$NVM_DIR" ]]; then
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    fi

elif [[ "$CURRENT_SHELL" = "-zsh" ]]; then
    if type brew &>/dev/null; then
        FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
        autoload -Uz compinit
        compinit
    fi
fi

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
