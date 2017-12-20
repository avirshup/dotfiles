HAPPYMOJI=(😀 😎 😇 🦄 💐 🌮 🍾 🎠 🚀 🎆 🎉 🎊 🎇 🏆 🥇 💰 🤓 😸 👩🏾‍🎓)
SADMOJI=(🤢 🤕 ☠ 💩 💣 🦂 🔪 🌋 🚑 🚒 🌪 🌩 ⚰ 🚬 🤔 😫 😖 😱 😡 👿 💀 😾 👹 👺)

function happymoji(){
   echo ${HAPPYMOJI[$(( $RANDOM % 19 ))]}
}

function sadmoji(){
   echo ${SADMOJI[$(( $RANDOM % 19 ))]}
}


function notify(){
   $@
   exitcode=$?
   if [ "${exitcode}" -ne 0 ]; then
      success="$(sadmoji) exit code: ${exitcode} $(sadmoji) $(sadmoji) $(sadmoji)"
   else
      success="$(happymoji) Success $(happymoji) $(happymoji) $(happymoji)"
   fi

   if [ $# -ge 4 ]; then
   	   title="$1 $2 $3 [...]"
   else
   	   title="$@"
   fi

   osascript -e "display notification \"${success}\" with title \"${title}\""
   return ${exitcode}
}
