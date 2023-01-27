# stop sourcing if this ain't darwin
if test $(uname) != "Darwin"
    return 0
end

alias top "top -o cpu"

function ql \
    -d "Invoke OS X quicklook/preview on a file" \
    -w qlmanage
    qlmanage -p $argv &>/dev/null &    
end