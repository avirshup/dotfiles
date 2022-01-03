function maybe-make-alias() {
	# make the alias only if the target is installed
	name=$1
	target=$2

	if which $target &>/dev/null; then
		alias $name=$target
	else
		echo "$target not installed"
	fi
}

maybe-make-alias diff colordiff
maybe-make-alias vi vim

alias strip-ansi="perl -pe 's/\x1b\[[0-9;]*m//g'"
alias tf="terraform"
alias pyshell="pyenv shell"
alias py.test="py.test -rEf"
alias sctl=supervisorctl

alias myps="ps x | grep -v /usr/libexec | grep -v '\.app' | grep -v '/Library'"

if [[ "$(uname)" = "Darwin" ]]; then
	alias top='top -o cpu'

	cpcb() {
		echo -n "$($@)" | pbcopy
	}

	ql() {
		qlmanage -p "$@" &>/dev/null
	}

	# https://apple.stackexchange.com/a/5461/64253
	cman() {
		man "${1}" | col -b | code -n -
	}

fi

function grep-repo() {
	git grep $@ $(git rev-list --all)
}

psgrep() {
	ps aux -NC grep | grep $@
}
