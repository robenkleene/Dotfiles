# Environment Variables
set PATH /usr/local/bin ~/Development/Scripts/bin $PATH

# Editor
set EDITOR mate

# rbenv
set PATH $HOME/.rbenv/bin $PATH
set PATH $HOME/.rbenv/shims $PATH
rbenv rehash >/dev/null ^&1

# Atom
set -x ATOM_PATH $HOME/Applications/Atom.app

# Node
set -x NODE_PATH /usr/local/share/npm/lib/node_modules /usr/local/lib/node_modules
set PATH /usr/local/share/npm/bin $PATH

# Prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow

set fish_color_comment 3a3a3a

function fish_prompt
	set_color $fish_color_comment
	echo -n (date "+%I:%M %p")
	echo -n ' '
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

# Emacs Client Magit
# function gc
# 	emacsclient -c -n --eval "(rk-magit-status-startup)"
# end

# Emacs Magit
function magit
	emacs --eval "(rk-magit-status-startup)"
end

# wcsearch
# function sea
#   wcsearch $argv
# end

# BBFind
function bbf
  bbfind --grep --gui --case-sensitive "$argv[1]" .
end

# BBFind in files
function bbff
  bbfind --grep --gui --case-sensitive --name-pattern "$argv[1]" "$argv[2]" .
end

# Files
function ackf
  ack -ig "$argv[1]"
end

# Misc
function cleanopenwith
	/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
end

# tig
function ts
	tig status
end

# Git
function gs
	git status
end
function gd
	git diff $argv
end

function ga
	git add :/
end

function gc
	git commit
end

function gl
	git log
end

function gca
	git commit --amend
end

function gcm
	git commit -m $argv[1]
end

function gcam
	git commit --amend -m $argv[1]
end