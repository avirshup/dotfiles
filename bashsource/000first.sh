prepend-pathvar() {
    varname=$1
    path=$2
    eval current=\$$varname  # gets current value as through indirect ref
    current=${path}${current:+:${current}}
    eval "$varname=$current"
    export ${varname}
}

append-pathvar() {
    varname=$1
    path=$2
    eval current=\$$varname 
    current=${current:+${current}:}${path}
    eval "$varname=$current"
    export ${varname}
}
