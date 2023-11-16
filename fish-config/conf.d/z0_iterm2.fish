# locate init file
set -l dotfile_init $DOTFILE_HOME/etc/iterm2_init.fish
if set -q DOTFILE_HOME && test -f $dotfile_init
    set -l iterminit $dotfile_init
else
    set -l iterminit $HOME/.iterm2_shell_integration.fish
end

# source init file if located
set -l iterminit $DOTFILE_HOME/etc/iterm2_init.fish
echo -n "    init iterm2"
if test $LC_TERMINAL = iTerm2 && test -f "$iterminit"
    source $iterminit; and echo " ✅ "; or echo ❌ " iterm source failed"
else
    echo ❌ " no iterm init file"
end