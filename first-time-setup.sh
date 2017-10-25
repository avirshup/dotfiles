#!/bin/bash

function echocmd(){ #echo the command and then run it
   echo "> $@"
   $@
}

flagstart="# AMV dotfile setup -- do not edit"
flagend="# end AMV dotfile setup -- do not edit"

bash_profile_loader="for file in ${PWD}/bashsource/*.sh; do
  echo \"==== Sourcing: \$file\"
  source \$file
done"

git_loader="[include]
   path = ${PWD}/gitconfig
"

function add-to-file(){
	target=$1
	content=$2
	if grep "$flagstart" $target &> /dev/null
		then
		echo "Loading hooks already detected in ${target}"
	else
		echo >> $target
		echo "$flagstart -- $(PWD)" >> ${target}
		echo "Adding loading hooks to ${target}"
		echo "$content" >> $target
		echo "$flagend" >> $target
	fi
}

add-to-file "${HOME}/.inputrc" "\$include $(PWD)/inputrc"
add-to-file "${HOME}/.bash_profile" "$bash_profile_loader"
add-to-file "${HOME}/.gitconfig" "$git_loader"







