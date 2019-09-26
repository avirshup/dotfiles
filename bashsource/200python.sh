
# Typing 'import lib' in shell will automatically
# launch ipython and run it
function import(){
	cmd="import $@"
    ipython -i -c "${cmd}"
}


function from(){
        cmd="from $@"
    ipython -i -c "${cmd}"
}

