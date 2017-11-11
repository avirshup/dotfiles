## DOCKER

export DEFAULT_MACHINE="default"

alias dm="docker-machine"
alias dmls="docker-machine ls"

function denv(){
  eval $(docker-machine env)
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


function getname() { # return specified name if passed or $CURRENT_MACHINE or $DEFAULT_MACHINE if not
    if [ -n "$1" ]; then
        echo $1
    else
	echo `dcurrent`
    fi
}



