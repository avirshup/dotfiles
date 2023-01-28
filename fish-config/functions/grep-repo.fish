function grep-repo
git grep $argv $(git rev-list --all)
end
