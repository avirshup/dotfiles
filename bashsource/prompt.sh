function get_dir(){
	thisdir='75'
	if [[ ${PWD} == ${HOME} ]]; then
		echo $(colornum '~' ${thisdir})
	else
		subdir=$(dirname ${PWD})
	    if [[ ${subdir} == ${HOME} ]]
	    then subdir="~"
	    else subdir=$(basename ${subdir})
	    fi
		echo "$(colornum ${subdir} ${defcolor})${slash}$(colornum $(basename ${PWD}) ${thisdir})";
    fi
}

function get_pyenv(){
	[ ${PYENV_VERSION} ] && echo ${PYENV_VERSION} || cat ${HOME}/.pyenv/version
}

function color_pyenv(){
	pv=$(get_pyenv)
	if [ ${pv:0:1} == '3' ]
	then num="99"
	else num="34"
	fi
	echo $(colornum $pv $num)
}

show_tput_colors(){
	for C in {0..255}; do
    tput setab $C
    echo -n "$C "
	done
	tput sgr0
	echo
}

function colornum(){
	echo "\[$(tput setaf $2)\]$1\[$(tput sgr0)\]"
}

defcolor="246"
start=$(colornum "[" $defcolor)
end=$(colornum "]\\$" $defcolor)
slash=$(colornum '/' $defcolor)


PROMPT_COMMAND='export PS1="${start}$(color_pyenv) $(get_dir)${end} "'
