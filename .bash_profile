# only update homebrew every day
export HOMEBREW_AUTO_UPDATE_SECS="86400"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

export GOPATH=~/work/go/
export PATH=$PATH:$GOPATH/bin

udate ()
{
	TZ=UTC date
}

gp ()
{
	SEARCH_PATH="${GOPATH}src"
	FOUND_PATH=$(find $SEARCH_PATH -type d -maxdepth 3 -name *$1 -print -quit)
	if [[ -n $FOUND_PATH ]]; then
		cd $FOUND_PATH
		echo "Switched to $FOUND_PATH"
	else
		echo "No match for '$1' inside $SEARCH_PATH"
	fi
}

ksh ()
{
	if [ -z $2 ]; then
		kubectl exec -it $1 -- ${3:-/bin/bash}
	else
		kubectl exec -it $1 -c $2 -- ${3:-/bin/bash}
	fi
}

venv ()
{
	if [ ! -f .venv/bin/activate ]; then
		virtualenv .venv
	fi
	. .venv/bin/activate
}

venv3 ()
{
	if [ ! -f .venv/bin/activate ]; then
		virtualenv -p python3 .venv
	fi
	. .venv/bin/activate
}

temp-venv ()
{
	TEMPDIR=$(mktemp -d)
	virtualenv $TEMPDIR
	$TEMPDIR/bin/activate
}
