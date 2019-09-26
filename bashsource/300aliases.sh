function make-alias(){
   name=$1
   target=$2

   if which $target &> /dev/null; then
	alias $name=$target
   else
	echo "$target not installed"
   fi
}

make-alias diff colordiff
make-alias vi vim
