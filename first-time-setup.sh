#!/bin/bash

if [ -e $HOME/.mackup.cfg ]; then
  echo "Won't overwrite existing mackup configuration"
else
  echocmd ln -s ${PWD}/etc/mackup.cfg $HOME/.mackup.cfg
fi

flagstart="AMV dotfile setup -- do not edit"
flagend="end AMV dotfile setup -- do not edit"

function add-to-file(){
	target=$1
	content=$2

	if [ -z $3 ]; then
	    comment="\#"
	else
	    comment=$3
	fi

	if grep "$flagstart" $target &> /dev/null
		then
		echo "Loading hooks already detected in ${target}"
	else
		echo >> $target
		echo "$comment $flagstart -- ${DOTFILE_HOME}" >> ${target}
		echo "Adding loading hooks to ${target}"
		echo "$content" >> $target
		echo "$comment $flagend" >> $target
	fi
}

# INPUTRC
add-to-file "${HOME}/.inputrc" "\$include ${PWD}/etc/inputrc"

# BASH_PROFILE
add-to-file "${HOME}/.bash_profile" "export DOTFILE_HOME=${PWD}
source \${DOTFILE_HOME}/sourceme.sh"

# GITCONFIG
add-to-file "${HOME}/.gitconfig" "[include]
   path = ${PWD}/etc/gitconfig"

# VIMRC
add-to-file "${HOME}/.vimrc" ":source ${PWD}/etc/vimrc" '"'


