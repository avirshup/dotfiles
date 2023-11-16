# Note to self: this is executed last, _after_ everything in `conf.d`
# https://fishshell.com/docs/current/language.html#configuration

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


#--- integrations ---#
# pyenv
type -q pyenv
and pyenv init - --no-rehash | source


# gnu parallel
type -q env_parallel.fish
and source (which env_parallel.fish)
