#!/bin/bash
if [ -z "$DOTFILE_HOME" ]; then
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
else
    DIR=${DOTFILE_HOME}
fi

echo "dotfile base: ${DIR}"


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
	    comment="#"
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
add-to-file "${HOME}/.inputrc" "\$include ${DIR}/etc/inputrc"

# BASH_PROFILE
add-to-file "${HOME}/.bash_profile" "export DOTFILE_HOME=${DIR}
source \${DOTFILE_HOME}/sourceme.sh"

# GITCONFIG
add-to-file "${HOME}/.gitconfig" "[include]
   path = ${DIR}/etc/gitconfig"

# VIMRC
add-to-file "${HOME}/.vimrc" ":source ${DIR}/etc/vimrc" '"'

# SLATERC
add-to-file "${HOME}/.slate" "source ${DIR}/etc/default.slate"