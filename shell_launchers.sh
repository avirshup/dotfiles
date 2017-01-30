alias SourceTree='/Applications/SourceTree.app/Contents/MacOS/SourceTree'
alias PyCharm='/Applications/PyCharm2016.2.app/Contents/MacOS/pycharm'

function mdtrelease() {
    if [ -n "$1" ]; then
	version=0.7.3
    else
	version="$1"
    fi

    docker run \
	   -v /var/run/docker.sock:/var/run/docker.sock \
           -v $HOME/.moldesign:/root/.moldesign \
	   -p 8888:8888 -it \
	   docker.io/autodesk/moldesign:moldesign_notebook-$version
}
