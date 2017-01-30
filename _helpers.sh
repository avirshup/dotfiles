function col(){ 
   awk "{print \$$1}" $2
}

function headcut(){ #don't print first N lines
   awk "NR>$1" $2
}

function echocmd(){ #echo the command and then run it
   echo "> $@"
   $@
}


function clean(){
    echocmd rm -fv \#* *~ \:*
}
