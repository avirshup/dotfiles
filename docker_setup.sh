## DOCKER

export DEFAULT_MACHINE="default"

alias dm="docker-machine"
alias dps="docker ps"
alias dim="docker images"
alias drm="docker rm"

alias dmls="docker-machine ls"

function docker-clean-all(){
    docker system prune
}

function docker-clean-images(){
   untagged=$(docker images | grep '<none>' | col 3)
   if [ -n "$untagged" ]; then
      echocmd docker rmi $@ $untagged
   else
      echo "No untagged images to clean"
   fi
}

function docker-clean-containers(){
   #TODO: deal with "Created" status too
   stopped=$(docker ps -a --filter status=exited | headcut 1 | col 1)
   if [ -n "$stopped" ]; then
     echocmd docker rm $@ $stopped
   else
     echo 'No stopped containers to clean'
   fi
}

function drestart(){
  mach=$(getname $1)
  echocmd docker-machine stop $mach
  dstart $mach
}

function dstart() { # start and set up environment for specified machine
    mach=$(getname $1)
    echocmd docker-machine start $mach
    denv $mach
    export CURRENT_MACHINE=$mach
}

function denv(){ # set up environment for specified machine
    mach=$(getname $1)
    env_cmd=$(docker-machine env $mach)
    echo "Setting docker environment for docker-machine $mach"
    echo "$env_cmd" | grep export
    eval "$env_cmd"
    export CURRENT_MACHINE=$mach
}

function dbash(){ #run bash in specified image
    if [ "$2" == '--socket' ] ; then
       flags='-v /var/run/docker.sock:/var/run/docker.sock'
    else
       flags=''
    fi
    echocmd docker run $flags -it --entrypoint=bash $1
}

function dcurrent(){
    if [ -n "$1" ]; then
	export CURRENT_MACHINE=$1;
    fi
    if [ -n "$CURRENT_MACHINE" ]; then
       echo $CURRENT_MACHINE
    else
       echo $DEFAULT_MACHINE
    fi
}

function lastcontainer(){
  containerid=`dps -l -f status=exited | headcut 1 | col 1`
  denter $containerid
}



function denter(){ # Open a terminal in this container or image
    info=$(docker inspect $1)
    if [ "$2" == '--socket' ] ; then
       flags='-v /var/run/docker.sock:/var/run/docker.sock'
    else
       flags=''
    fi
    echo $info | grep -s "RepoTags" > /dev/null
    if [ $? -eq 0 ]; then  # it's an image
       dbash $1 $2
    else  # it's a container
	echo $info | grep -s '"Running": true,' > /dev/null
	if [ $? -eq 0 ]; then # it's running now
	    echocmd docker exec -it $1 bash
	else # it's stopped
	    echocmd docker commit $1 denter_temptemp
	    echocmd docker run $flags --entrypoint=bash -it denter_temptemp
	fi
    fi
}

function getname() { # return specified name if passed or $CURRENT_MACHINE or $DEFAULT_MACHINE if not
    if [ -n "$1" ]; then
        echo $1
    else
	echo `dcurrent`
    fi
}



