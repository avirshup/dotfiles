#launchctl setenv PYTHONPATH $PYTHONPATH
launchctl setenv PATH $PATH
launchctl setenv AMBERHOME $AMBERHOME
launchctl setenv GREP_OPTIONS $GREP_OPTIONS
launchctl setenv LSCOLORS $LSCOLORS

function notify(){
   $@
   exitcode=$?
   if [ "${exitcode}" -ne 0 ]; then
      success="ERROR ${exitcode}"
   else
      success='Success'
   fi

   if [ $# -ge 4 ]; then
   	   title="$1 $2 $3 [...]"
   else
   	   title="$@"
   fi

   osascript -e "display notification \"${success}\" with title \"${title}\""
   return ${exitcode}
}
