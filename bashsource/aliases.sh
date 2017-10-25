function mdtrelease() {
    if [ -n "$1" ]; then
	version=0.7.3
    else
	version="$1"
    fi

    docker run \
	   -v /var/run/docker.sock:/var/run/docker.sock \
           -v $HOME/.moldesign:/root/.moldesign \
	   -p 8890:8888 -it \
	   docker.io/autodesk/moldesign:moldesign_notebook-$version
}

function pyscf-activate(){
	if [ "${_pyscfactive}" != "1" ]; then

		PYSCFBASE=/Users/aaronvirshup/python_pkg/pyscf_pkg
	    export DYLD_LIBRARY_PATH=${PYSCFBASE}/pyscf/lib/deps/lib:${DYLD_LIBRARY_PATH}
	    export PYTHONPATH=${PYSCFBASE}:${PYTHONPATH}
		export _pyscfactive=1
	fi
}

