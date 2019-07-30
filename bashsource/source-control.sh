function grep-repo(){
git grep $@ $(git rev-list --all)
}


