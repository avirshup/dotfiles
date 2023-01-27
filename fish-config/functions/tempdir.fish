function tempdir \
    -d 'create and cd to a new dir under ~/tmp' \
    -a name
    
    if test -z $name
        echo "Usage: tempdir (name)"
        return 1
    end
    
    set -f d ~/tmp/$name
    if test -d $d
        echo "Existing directory: $d"
    else
        echo "New directory: $d"
        echocmd mkdir -p $d
    end
    echocmd cd $d
end