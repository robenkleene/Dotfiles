export PATH=/usr/local/bin:~/Development/Scripts/bin:$PATH
if [ "$(uname)" = "Darwin" ]; then
	export PATH=~/bin:$PATH
fi
set -x EDITOR nvim
