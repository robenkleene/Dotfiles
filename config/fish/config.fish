set PATH /usr/local/bin ~/Development/Scripts/bin $PATH

set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow

function fish_prompt
	set_color $fish_color_cwd
	echo -n (prompt_pwd)
	set_color normal
	echo -n '> '
end

function fish_right_prompt
	echo -n (__fish_git_prompt)
end

function egitn
    set --local EGITNEXT (egit -n)
	if test -n "$EGITNEXT"
		cd $EGITNEXT
		git status
	end
end

# Emacs Client
function ec
	emacsclient -c -n
end

# Emacs Magit
function gc
	emacsclient -c -n --eval "(rk-magit-status-startup)"
end

# rbenv
set PATH $HOME/.rbenv/bin $PATH
set PATH $HOME/.rbenv/shims $PATH
rbenv rehash >/dev/null ^&1

# Node
set -x NODE_PATH /usr/local/share/npm/lib/node_modules /usr/local/lib/node_modules
set PATH /usr/local/share/npm/bin $PATH