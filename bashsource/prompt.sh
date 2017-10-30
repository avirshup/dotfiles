function get_dir(){
	thisdir='75'
	if [[ ${PWD} == ${HOME} ]]; then
		echo $(colornum '~' ${thisdir})
	else
		subdir=$(dirname "${PWD}")
	    if [[ "${subdir}" == ${HOME} ]]
	    then subdir="~"
	    else subdir=$(basename "${subdir}")
	    fi
		d1=$(colornum "${subdir}" ${defcolor})
		d2=$(colornum $(basename "${PWD}") "${thisdir}");
		echo "${d1}${slash}${d2}"
    fi
}

function get_pyenv(){
	[ ${PYENV_VERSION} ] && echo ${PYENV_VERSION} || cat ${HOME}/.pyenv/version
}

function color_pyenv(){
	pv=$(get_pyenv)
	fc=${pv:0:1}
	if [ ${fc} == '3' ]; then num="99"
	elif [ ${fc} == '2' ]; then num="34"
	else num="36"
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

if which pyenv && get_pyenv &>/dev/null ; then
    PROMPT_COMMAND='export PS1="${start}$(color_pyenv) $(get_dir)${end} "'
else
    PROMPT_COMMAND='export PS1="${start}$(hostname) $(get_dir)${end} "'
fi
