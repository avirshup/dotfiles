## DOCKER

export DEFAULT_MACHINE="default"

alias dps="docker ps"
alias dim="docker images"
alias drm="docker rm"

function dbash(){ #run bash in specified image
    if [ "$2" == '--socket' ] ; then
       flags='-v /var/run/docker.sock:/var/run/docker.sock'
    else
       flags=''
    fi
    echocmd docker run $flags -it --entrypoint=bash $1
}


function lastcontainer(){
  containerid=`dps -l -f status=exited | headcut 1 | col 1`
  denter $containerid
}



function denter(){ # Open a terminal in this container or image
    info=$(docker inspect $1)
    exists=$?
    if [ "$2" == '--socket' ] ; then
       flags='-v /var/run/docker.sock:/var/run/docker.sock'
    else
       flags=''
    fi
    echo $info | grep -s "RepoTags" > /dev/null
    if [ $? -eq 0 ]; then  # it's an image
       dbash $1 $2
    elif [ $exists -eq 0 ] ; then  # it's a container
	echo $info | grep -s '"Running": true,' > /dev/null
	if [ $? -eq 0 ]; then # it's running now
	    echocmd docker exec -it $1 bash
	else # it's stopped
	    echocmd docker commit $1 denter_temptemp
	    echocmd docker run $flags --entrypoint=bash -it denter_temptemp
	fi
    else
       echo "No image or container named '$1'"
    fi
}

function getname() { # return specified name if passed or $CURRENT_MACHINE or $DEFAULT_MACHINE if not
    if [ -n "$1" ]; then
        echo $1
    else
	echo `dcurrent`
    fi
}



