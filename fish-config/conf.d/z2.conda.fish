function _ensure_conda_init --description "Replaces conda init in config.fish"

    # check if we need to run this
    set -q __CONDA_WAS_INITED; and return 0
    set -f conda_exe (command -v conda); or return 1

    set -f conda_prefix ($conda_exe info --base)

    # Contents within this block **were** managed by 'conda init'
    for exe in conda mamba
        set -l initfile $conda_prefix/etc/fish/conf.d/$exe.fish
        if test -f $initfile
            echo -n "  🐍 init $exe"
            source $initfile; and echo " ✅ "; or echo ❌
        end
    end

    set -g __CONDA_WAS_INITED $conda_prefix
end


function _on_conda_env_change \
    -v CONDA_PREFIX \
    -d "Set python version variable whenever conda env changes"

    if type -q python
        set -gx _CURRENT_PYTHON_VERSION (python -c "import sys; print('🐍' + '.'.join(map(str, sys.version_info[:3])))")
    else
        set -ge _CURRENT_PYTHON_VERSION
    end
end

_ensure_conda_init