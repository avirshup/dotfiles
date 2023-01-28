#!/usr/bin/env zsh

MAXDEPTH=100

up(){
    if [ -z "$1" ]; then
        _show_updirs
        echo -n "Which? "
        read n
    else
        n=$1
    fi

    if [ -z "${n// }" ]; then
        echo "Cancelled"
        return
    fi

    newdir=''
    while (( $n > 0 )); do
        ((n--)) || :
        newdir="${newdir}../"
    done

    if [ ! -z "$newdir" ]; then
        cd "$newdir"
    fi
    echo "-> $(pwd)"
}

_show_updirs() {  
    d=$(pwd)
    for i in $(seq 0 $MAXDEPTH); do
        shortname=$(basename "$d")
        printf "%3s) %-20s -> %s\n" $i "$shortname" "$d"
        if [[ "$d" = '/' ]]; then
            break
        else
            d=$(dirname "$d")
        fi
    done
}


reporoot() {
    curdir=""
    for i in $(seq 1 $MAXDEPTH); do
        curdir="$curdir../"
        if [ -d "$curdir/.hg" ] || [ -d "$curdir/.git" ]; then
            echocmd cd "$curdir"
            echo $(pwd)
            return 0
        fi
        if [[ $(realpath "$curdir") = "/" ]]; then
            echo "No repo root found; pwd unchanged"
            return 1
        fi
    done
}
