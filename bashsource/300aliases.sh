function make-alias() {
	name=$1
	target=$2

	if which $target &>/dev/null; then
		alias $name=$target
	else
		echo "$target not installed"
	fi
}

make-alias diff colordiff
make-alias vi vim

alias strip-ansi="perl -pe 's/\x1b\[[0-9;]*m//g'"
alias tf="terraform"
alias pyshell="pyenv shell"
alias py.test="py.test -rEf"

alias myps="ps x | grep -v /usr/libexec | grep -v '\.app' | grep -v '/Library'"

if [ "$(uname)" == "Darwin" ]; then
	cpcb() {
		echo -n "$($@)" | pbcopy
	}

	ql() {
		qlmanage -p "$@" &>/dev/null
	}

	# https://apple.stackexchange.com/a/5461/64253
	cman () {
    	man "${1}" | col -b | code -n -
	}

fi

function _click_autocomplete() {
	if [ ! -z "$1" ] && (command -v "$1" >/dev/null); then
		export _DEV_QUICKLOAD=1
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

alias sctl=supervisorctl

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
