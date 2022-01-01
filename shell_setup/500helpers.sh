function quickdev() {
    case "$1" in
        "on")
        export _DEV_QUICKLOAD=1
        ;;
        "off")
        unset _DEV_QUICKLOAD
        ;;
        *)
        echo "Usage: quickdev (on|off)"
        return 1
    esac
}

function tempdir() {
	name="$1"
	if [ -z "$name" ]; then
		echo "please provide a name."
		return 1
	fi
	d="$HOME/tmp/$name"
	mkdir -p "$d"
	echo $d
	cd "$d"
}

function _click_autocomplete() {
	if [ ! -z "$1" ] && (command -v "$1" >/dev/null); then
		quickdev on
		echo "Setting up autocomplete for '$1' command ..."
		acscript="$(eval "_${1^^}_COMPLETE=bash_source $1")"
		eval "$acscript"
	else
		echo "Please provide click command to autocomplete"
	fi
}

function pyscf-activate() {
	if [ "${_pyscfactive}" != "1" ]; then
		PYSCFBASE=/Users/aaronvirshup/python_pkg/pyscf_pkg

		prepend-pathvar DYLD_LIBRARY_PATH ${PYSCFBASE}/pyscf/lib/deps/lib
		prepend-pathvar PYTHONPATH ${PYSCFBASE}
		export _pyscfactive=1
	fi
}

function exportenv () {
    # FROM https://stackoverflow.com/a/20909045/1958900
    if [ $# != 1 ] ; then
        echo 'USAGE: exportenv [env file]'
        return 1
    fi

    export $(cat $1 | grep -v '^#' | xargs)
}


