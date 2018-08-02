#!/bin/bash

# this is an "associative array" (a dict more or less)
orange=208
green=22
red=196
white=246
blue=75
purple=99
darkgreen=34
forest=36

declare -A lettercolors=([l]=$green [p]=$orange [m]=$red [b]=$blue)


function get_dir(){
    thisdir='75'
    if [[ "${PWD}" == "${HOME}" ]]; then
        colortext '~' ${thisdir}
    else
        subdir=$(dirname "${PWD}")
        if [[ "${subdir}" == "${HOME}" ]]
        then subdir="~"
        else subdir=$(basename "${subdir}")
        fi
        d1=$(colortext "${subdir}" "${defcolor}")
        d2=$(colortext $(basename "${PWD}") "${thisdir}");
        echo "${d1}${slash}${d2}"
    fi
}

function get_pyenv(){    
    v=$(pyenv version-name)
    if [[ "${v}" == *"conda"* ]]; then
        if [ ! -z "$CONDA_DEFAULT_ENV" ] && [ "$CONDA_DEFAULT_ENV" != 'root' ]; then
            colortext "$CONDA_DEFAULT_ENV" $orange
        else
            colortext "${v}" "$purple"
        fi
    elif [ ! -z "${v}" ]; then
        if [ "${v}" == "${CONDA_DEFAULT_ENV}" ]; then
            colortext "$CONDA_DEFAULT_ENV" $orange
        elif [ ${v:0:1} == '2' ]; then
            colortext "${v}" $red
        elif [ ${v:0:1} == '3' ]; then
            colortext "${v}" $blue
        elif [ "$v" == 'system' ]; then
            colortext "${v}" $white
        else
            colortext "${v}" "$purple"
        fi
    else
        colortext system $white
    fi
}

function colortext(){
    echo "\[$(tput setaf $2)\]$1\[$(tput sgr0)\]"
}


show_tput_colors(){
    for C in {0..255}; do
    tput setab $C
    echo -n "$C "
    done
    tput sgr0
    echo
}


function color-by-first-letter(){
    letter=${1:0:1}
    color=${lettercolors[${letter,,}]}
    if [ -z "${color}" ]; then
        color=$defcolor
    fi
    colortext "$1" "$color"
}

function get-hostname(){
    # https://stackoverflow.com/a/5268527/1958900
    h=$(hostname)
    firstname=$(hostname | cut -d"." -f1)
    color-by-first-letter "${firstname}"
}

defcolor=$white
start=$(colortext "[" $defcolor)
end=$(colortext "]\\$" $defcolor)
slash=$(colortext '/' $defcolor)

hash pyenv &> /dev/null
pyenv_exists=$?

if [ ${pyenv_exists} ] ; then
    PROMPT_COMMAND='export PS1="${start}$(get-hostname) $(get_pyenv) $(get_dir)${end} "'
else
    PROMPT_COMMAND='export PS1="${start}$(hostname) $(get_dir)${end} "'
fi
