# Note to self: this is executed last, _after_ everything in `conf.d`
# https://fishshell.com/docs/current/language.html#configuration

#--- shell setup ---#
# custom prompt
set -Ux STARSHIP_CONFIG /Users/avirshup/dotfiles/starship.toml
starship init fish | source

#--- paths ---#
# note these won't be added if they don't exist
# or if they're already in the path
fish_add_path -U \
    ~/.pyenv/bin \
    /opt/homebrew/bin \
    /usr/local/bin \
    ~/.local/bin \
    ~/bin \
    ~/dotfiles/bin \
    ~/.ghcup/bin \
    ~/.cabal/bin

# pipx
set -g PIPX_DEFAULT_PYTHON ~/.pyenv/versions/pipx_interpreter/bin/python
if test -x $PIPX_DEFAULT_PYTHON
    set -gx PIPX_DEFAULT_PYTHON $PIPX_DEFAULT_PYTHON
else
    set -e PIPX_DEFAULT_PYTHON
end
    
#--- integrations ---#
# pyenv
type -q pyenv; and \
    pyenv init - --no-rehash | source

# iterm
test -f {$HOME}/.iterm2_shell_integration.fish ; and \
    source {$HOME}/.iterm2_shell_integration.fish

# gnu parallel
type -q env_parallel.fish; and \
    source env_parallel.fish