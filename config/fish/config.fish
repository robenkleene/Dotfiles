# Environment Variables
set PATH /usr/local/bin ~/Development/Scripts/bin $PATH

# Editor
set EDITOR mate

# rbenv
set PATH $HOME/.rbenv/bin $PATH
set PATH $HOME/.rbenv/shims $PATH
rbenv rehash >/dev/null ^&1

# Atom
set -x ATOM_PATH $HOME/Applications/
set -x ATOM_REPOS_HOME $HOME/Development/Projects/Atom

# Node
set -x NODE_PATH /usr/local/share/npm/lib/node_modules /usr/local/lib/node_modules
set PATH /usr/local/share/npm/bin $PATH

# Coffeelint
set -x COFFEELINT_CONFIG $HOME/.coffeelint.json


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
  switch (count $argv)
      case 1
          bbfind --grep --gui --case-sensitive "$argv[1]" .
      case '*'
          bbfind --grep --gui --case-sensitive $argv
  end
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

# # gitsh
# function g
# 	gitsh
# end

# function make_completion --argument alias command
#     complete -c $alias -xa "(
#         set -l cmd (commandline -pc | sed -e 's/^ *\S\+ *//' );
#         complete -C\"$command \$cmd\";
#     )"
# end
# function g
# 	git $argv
# end
# make_completion g 'git'
set -U fish_user_abbreviations 'g=git'
set fish_user_abbreviations $fish_user_abbreviations 'ts=tig status'
set fish_user_abbreviations $fish_user_abbreviations 'gs=git status'
set fish_user_abbreviations $fish_user_abbreviations 'gd=git diff'
set fish_user_abbreviations $fish_user_abbreviations 'gdt=git difftool'
set fish_user_abbreviations $fish_user_abbreviations 'gdm=git diff | mate'
set fish_user_abbreviations $fish_user_abbreviations 'ga=git add'
set fish_user_abbreviations $fish_user_abbreviations 'gb=git branch'
set fish_user_abbreviations $fish_user_abbreviations 'gaa=git add --all'
set fish_user_abbreviations $fish_user_abbreviations 'gc=git commit'
set fish_user_abbreviations $fish_user_abbreviations 'gp=git push'
set fish_user_abbreviations $fish_user_abbreviations 'gu=git pull'
set fish_user_abbreviations $fish_user_abbreviations 'gpl=git pull'
set fish_user_abbreviations $fish_user_abbreviations 'gl=git log'
set fish_user_abbreviations $fish_user_abbreviations 'gco=git checkout'
set fish_user_abbreviations $fish_user_abbreviations 'gca=git commit --am'
set fish_user_abbreviations $fish_user_abbreviations 'gcm=git commit -m'
set fish_user_abbreviations $fish_user_abbreviations 'gcam=git commit --am -m'
set fish_user_abbreviations $fish_user_abbreviations 'gsi=git submodule init'
set fish_user_abbreviations $fish_user_abbreviations 'gsu=git submodule update'


# # tig
# function ts
# 	tig status
# end
#
# # Git
# function gs
# 	git status
# end
#
# function gd
# 	git diff $argv
# end
#
# function gdt
# 	git difftool $argv
# end
#
# function gdm
# 	git diff | mate
# end
#
# function ga
# 	git add $argv
# end
#
# function gb
# 	git branch
# end
#
# function gaa
# 	git add --all
# end
#
# function gc
# 	git commit
# end
#
# function gp
# 	git push
# end
#
# function gu
# 	git pull
# end
#
# function gpl
# 	git pull
# end
#
# function gl
# 	git log $argv
# end
#
# function gco
# 	git checkout $argv
# end
#
# function gca
# 	git commit --amend
# end
#
# function gcm
# 	git commit -m $argv[1]
# end
#
# function gcam
# 	git commit --amend -m $argv[1]
# end
#
# function gsi
# 	git submodule init
# end
#
# function gsu
# 	git submodule update
# end