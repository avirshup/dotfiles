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
	v=$(pyenv version-name)
    if [ ! -z "${v}" ]; then
	    echo ${v}
    else
        echo system
    fi
}

function color_pyenv(){
	pv=$(get_pyenv)
	if [[ ${pv} == *'3'* ]]; then num="99"
	elif [[ ${pv} == *'2'* ]]; then num="34"
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

function get-hostname(){
  	# https://stackoverflow.com/a/5268527/1958900
    h=$(hostname)
    firstname=$(hostname | cut -d"." -f1)
    if [ ${h##*.} == 'local' ]; then
        hostcolor=22
    else
        hostcolor=160
    fi
	echo $(colornum "${firstname}" ${hostcolor})
}

defcolor="246"
start=$(colornum "[" $defcolor)
end=$(colornum "]\\$" $defcolor)
slash=$(colornum '/' $defcolor)

hash conda &> /dev/null
conda_exists=$?

if [ ${conda_exists} ] ; then
    PROMPT_COMMAND='export PS1="${start}$(get-hostname) $(color_pyenv) $(get_dir)${end} "'
else
    PROMPT_COMMAND='export PS1="${start}$(hostname) $(get_dir)${end} "'
fi
