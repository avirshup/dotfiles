#!/usr/bin/env zsh

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
    for i in $(seq 0 20); do
        shortname=$(basename "$d")
        printf "%3s) %-20s -> %s\n" $i "$shortname" "$d"
        if [[ "$d" = '/' ]]; then
            break
        else
            d=$(dirname "$d")
        fi
    done
}
