#!/usr/bin/env bash

usage() {
    echo " USAGE:
 > make-manifest [--markdown] (dir-or-file1) [dir-or-file2 ...]

Prints a table 
"
}

main() {
    printit "File" "Size" "SHA-256"
    if test $MD = "true"; then
        printit "----" "----" "----"
    fi

    for path in "$@"; do
        if test -f "$path"; then
            printrow "$path"
        elif test -d "$path"; then
            printdir "$path"
        else
            echo "ERROR: $path" is not a directory or file.
            exit 1
        fi
    done
}

printdir() {
    find -s "$1" -type f -not -path '*/\.*' | sort -sf | while read -r f; do
        printrow "$f"
    done
}

printrow() {
    f=$1
    if ! test -f "$f"; then
        echo "$f isn't a file."
        return 1
    fi
    printit \
        "$1" \
        "$(du -sh "$f" | awk '{print $1}')" \
        "$(shasum -a 256 "$f" | awk '{print $1}')"
}

printit() {
    if test $MD = "true"; then
        printf "| %-10s | %-8s | %s |\n" "$@"
    else
        printf "%-10s %-8s %s\n" "$@"
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    if test "$1" = "--markdown"; then
        MD="true"
        shift
    else
        MD="false"
    fi

    set -euo pipefail
    main "$@"
fi
