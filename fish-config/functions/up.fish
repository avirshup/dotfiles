function up \
    -d "interactively move up the filesystem" \
    -a n
    
    if test -z $n
        _show_updirs
        read -f n -P "Which? "
    end
    
    if test -z $(string trim $n)
        echo "Cancelled"
        return 0
    end
    
    set -f newdir ''
    for i in $(seq $n)
        set newdir "$newdir../"
    end

    echocmd cd "$newdir"
end

function _show_updirs
    set -f d $(pwd)
    for i in $(seq 0 20)
        set -l shortname $(basename "$d")
        printf "%3s) %-20s -> %s\n" $i "$shortname" "$d"
        if test $d = "/"
            break
        else
            set -f d $(dirname "$d")
        end
    end
end