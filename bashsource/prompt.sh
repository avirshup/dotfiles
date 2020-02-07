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
taupe=242
crimson=125
mauve=54
barf=100

declare -A numcolors=([0]=$green [1]=$orange [2]=$red [3]=$blue [4]=$purple [5]=$taupe [6]=$forest [7]=$crimson [8]=$mauve [9]=$barf)


function get_dir(){
    thisdircolor='75'
    if [[ "${PWD}" == "${HOME}" ]]; then
        colortext '~' ${thisdircolor}
    else
        subdir=$(dirname "${PWD}")
        if [[ "${subdir}" == "${HOME}" ]]
            then subdir="~"
        else
            subdir=$(basename "${subdir}")
        fi
        if [[ "${subdir}" == "/" ]]; then
            subdir=""
        fi
        thisdir=$(basename "${PWD}")
        d1=$(colortext "${subdir}" "${defcolor}")
        d2=$(colortext "${thisdir}" "${thisdircolor}");
        echo "${d1}${slash}${d2}"
    fi
}

function get_pyenv(){    
    v=$(pyenv version-name)
    if [ ! -z "${v}" ]; then
        color-by-hash "$v"
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


function color-by-hash(){
    hashnum=$(cksum <<< $1 | cut -f 1 -d ' ')
    num=${hashnum: -1}
    
    color=${numcolors[${num,,}]}
    if [ -z "${color}" ]; then
        color=$defcolor
    fi
    colortext "$1" "$color"
}

function get-hostname(){
    # https://stackoverflow.com/a/5268527/1958900
    h=$(hostname)
    firstname=$(hostname | cut -d"." -f1)
    color-by-hash "${firstname}"
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
