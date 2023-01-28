PIPX_DEFAULT_PYTHON="~/.pyenv/versions/pipx_interpreter/bin/python"
if [ -x "$PIPX_DEFAULT_PYTHON" ]; then
    export PIPX_DEFAULT_PYTHON
fi

# Typing 'import lib' in shell will automatically
# launch ipython and run it
function import() {
    cmd="import $@"
    ipython -i -c "${cmd}"
}

function from() {
    cmd="from $@"
    ipython -i -c "${cmd}"
}
