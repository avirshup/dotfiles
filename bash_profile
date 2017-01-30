export PATH=$HOME/bin:/usr/local/bin:$PATH
export MANPATH=$MANPATH:/usr/man:/usr/local/man

source ~/.local/bin/bashmarks.sh

export EDITOR=emacs
export SVN_EDITOR=emacs 
export TMOUT=0
export LOCALBIN=yes #is this leftover from MOLPRO?

alias vmd='/Applications/VMD\ 1.9.2.app/Contents/vmd/vmd_MACOSXX86'
export AMBERHOME=/Users/aaronvirshup/installs/amber14
export DYLD_LIBRARY_PATH=/Developer/NVIDIA/CUDA-7.0/lib:$HOME/lib

function lastchar(){
    f=$1
    length=${#f}
    ((length--))
    echo "${f:$length:1}"
}

for file in $HOME/dotfiles/bashsource/*.sh; do
    
    echo "==== Sourcing: $file"
    source $file
done

# added by psi4conda installer
export PATH="$PATH:/usr/local/psi4conda/bin"
