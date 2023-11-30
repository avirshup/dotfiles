function up \
    -d "interactively move up the filesystem" \
    -a target

    # collect parents
    set -f paths "$(pwd)"
    set -f dirnames
    for i in $(seq 1 20)
        # process last path
        set -af dirnames (string lower (basename "$paths[$i]"))
        if test -z "$target"
            printf "%3s) %-20s -> %s\n" (math $i - 1) (basename "$paths[$i]") "$paths[$i]"
        end

        # return or add another path
        test "$paths[$i]" = "/"; and break
        set -af paths (dirname "$paths[$i]")
    end
    
    # prompt if no argument
    if test -z "$target"
        read -f target -P "Which? "
    end

    # find the new path
    if string match -qr '^[0-9]+$' "$target"
        set -f newpath $paths[(math "$target" + 1)]
        if contains "$target" "$dirnames"
            set_color red
            echo "WARNING: '$target' is a directory _and_ index. Interpreting as index."
            set_color normal
        end
    else if set -f foundidx (contains -i (string lower "$target") $dirnames)
        # selected by index
        set -f newpath $paths[$foundidx]
    end

    # done, omg
    if test -z "$newpath"
        echo "'$target' is not a directory or nesting level."
        return 1
    end
    echocmd cd "$newpath"
end