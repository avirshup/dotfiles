function make-alias(){
   name=$1
   target=$2

   if which $target &> /dev/null; then
	alias $name=$target
   else
	echo "$target not installed"
   fi
}

make-alias diff colordiff
make-alias vi vim

alias strip-ansi="perl -pe 's/\x1b\[[0-9;]*m//g'"

alias conda2="pyenv shell miniconda-latest"
alias conda3="pyenv shell miniconda3-latest"


function pyscf-activate(){
	if [ "${_pyscfactive}" != "1" ]; then
		PYSCFBASE=/Users/aaronvirshup/python_pkg/pyscf_pkg

	    prepend-pathvar DYLD_LIBRARY_PATH ${PYSCFBASE}/pyscf/lib/deps/lib
	    prepend-pathvar PYTHONPATH ${PYSCFBASE}
		export _pyscfactive=1
	fi
}

