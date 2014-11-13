# Environment Variables
set -x PATH /usr/local/bin ~/Development/Scripts/bin $PATH

# Editor
set -x EDITOR vim
function EDITOR; vim $argv; end


# rbenv
set PATH $HOME/.rbenv/bin $PATH
set PATH $HOME/.rbenv/shims $PATH
rbenv rehash >/dev/null ^&1

# nvm-fish
source ~/.nvm-fish/nvm.fish

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

# Git
set -U fish_user_abbreviations 'g=git'
set fish_user_abbreviations $fish_user_abbreviations 'gs=git status'
set fish_user_abbreviations $fish_user_abbreviations 'gd=git diff'
set fish_user_abbreviations $fish_user_abbreviations 'gdt=git difftool'
set fish_user_abbreviations $fish_user_abbreviations 'gdn=git diff --name-only'
set fish_user_abbreviations $fish_user_abbreviations 'gdm=git diff | mate'
set fish_user_abbreviations $fish_user_abbreviations 'ga=git add'
set fish_user_abbreviations $fish_user_abbreviations 'gb=git branch'
set fish_user_abbreviations $fish_user_abbreviations 'gm=git merge'
set fish_user_abbreviations $fish_user_abbreviations 'gaa=git add --all :/'
set fish_user_abbreviations $fish_user_abbreviations 'gc=git commit'
set fish_user_abbreviations $fish_user_abbreviations 'gp=git push'
set fish_user_abbreviations $fish_user_abbreviations 'gu=git pull'
set fish_user_abbreviations $fish_user_abbreviations 'gpl=git pull'
set fish_user_abbreviations $fish_user_abbreviations 'gl=git log'
set fish_user_abbreviations $fish_user_abbreviations 'gco=git checkout'
set fish_user_abbreviations $fish_user_abbreviations 'gcob=git checkout -b'
set fish_user_abbreviations $fish_user_abbreviations 'gcl=git clone'
set fish_user_abbreviations $fish_user_abbreviations 'gca=git commit --amend'
set fish_user_abbreviations $fish_user_abbreviations 'gcm=git commit -m'
set fish_user_abbreviations $fish_user_abbreviations 'gcam=git commit --amend -m'
set fish_user_abbreviations $fish_user_abbreviations 'gsi=git submodule init'
set fish_user_abbreviations $fish_user_abbreviations 'gsu=git submodule update'
set fish_user_abbreviations $fish_user_abbreviations 'gur=git pull --rebase'
set fish_user_abbreviations $fish_user_abbreviations 'gpbo=git push --set-upstream origin (git rev-parse --abbrev-ref HEAD)'

function git-push-branch-origin
	git push --set-upstream origin (git rev-parse --abbrev-ref HEAD)
end

# egit
function egitn
    set --local EGITNEXT (egit -n)
	if test -n "$EGITNEXT"
		cd $EGITNEXT
		git status
	end
end

# Tig
function ts
  tig status +3
end

# Hub
set fish_user_abbreviations $fish_user_abbreviations 'hb=hub browse'
set fish_user_abbreviations $fish_user_abbreviations 'hbc=hub browse -- commits'
# function hbc
#   hub browse -- commits
# end

# Git Tower
# set fish_user_abbreviations $fish_user_abbreviations 'gt=gittower .'

# Navigation
function o
  open .
end
function re
  open -R .
end
function -
  cd -
end

# Ranger
function ranger-cd
  set tempfile '/tmp/chosendir'
  ranger --choosedir=$tempfile (pwd)
  if test -f $tempfile
      if [ (cat $tempfile) != (pwd) ]
        cd (cat $tempfile)
      end
  end
  rm -f $tempfile
end
function fish_user_key_bindings                                                  
    bind \co 'ranger-cd ; fish_prompt'                                           
end
function rc
  ranger-cd
end


# Misc
function cleanopenwith
	/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
end


# Ack
function ackf
  ack -ig "$argv[1]"
end

# BBFind
function bbf
  switch (count $argv)
      case 1
          bbfind --grep --gui --case-sensitive "$argv[1]" .
      case '*'
          bbfind --grep --gui --case-sensitive $argv
  end
end
# BBFind Files
function bbff
  bbfind --grep --gui --case-sensitive --name-pattern "$argv[1]" "$argv[2]" .
end

# Emacs Client
# Creates a new window
# function ec
#   emacsclient --create-frame --no-wait $argv
# end
function ec
	emacsclient --no-wait $argv
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

# VIM
set fish_user_abbreviations $fish_user_abbreviations 'vp=vimpager'
function pvim
    sh -c "cat | vim -g - > /dev/null 2>&1"
end
function vc
    vim -c "set ft=fish" 
end
function vcc
    pbpaste | vim - -c "set ft=fish" 
end
function vcgb
    git rev-parse --abbrev-ref HEAD | vim - -c "set ft=fish" 
end
# This doesn't work, might have hung
# function tpvim
#     tee /dev/tty | sh -c "cat | vim -g - > /dev/null 2>&1"
# end

# Highlight
function hl
  highlight -O ansi "$argv[1]"
end

# Edit Dotfiles
set fish_user_abbreviations $fish_user_abbreviations 'edf=EDITOR ~/Dotfiles/config/fish/config.fish'
