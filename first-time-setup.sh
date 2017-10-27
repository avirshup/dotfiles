#!/bin/bash

function echocmd(){ #echo the command and then run it
   echo "> $@"
   $@
}

flagstart="# AMV dotfile setup -- do not edit"
flagend="# end AMV dotfile setup -- do not edit"

bash_profile_loader="export DOTFILE_HOME=${PWD}
source \${DOTFILE_HOME}/sourceme.sh"

git_loader="[include]
   path = ${PWD}/etc/gitconfig
"

function add-to-file(){
	target=$1
	content=$2
	if grep "$flagstart" $target &> /dev/null
		then
		echo "Loading hooks already detected in ${target}"
	else
		echo >> $target
		echo "$flagstart -- ${DOTFILE_HOME}" >> ${target}
		echo "Adding loading hooks to ${target}"
		echo "$content" >> $target
		echo "$flagend" >> $target
	fi
}

add-to-file "${HOME}/.inputrc" "\$include ${PWD}/etc/inputrc"
add-to-file "${HOME}/.bash_profile" "$bash_profile_loader"
add-to-file "${HOME}/.gitconfig" "$git_loader"








