# Note to self: this is executed last, _after_ everything in `conf.d`
# https://fishshell.com/docs/current/language.html#configuration

#--- shell setup ---#
# custom prompt
set -Ux STARSHIP_CONFIG /Users/avirshup/dotfiles/starship.toml
starship init fish | source

#--- paths ---#
# note these won't be added if they don't exist
fish_add_path -U \
    ~/.pyenv/bin \
    /opt/homebrew/bin \
    /usr/local/bin \
    ~/.local/bin \
    ~/bin \
    ~/dotfiles/bin

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
test -f (which env_parallel.fish); and \
    source (which env_parallel.fish)