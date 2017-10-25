alias clean-repo="git clean -x -d -i"

function grep-repo(){
git grep $@ $(git rev-list --all)
}


