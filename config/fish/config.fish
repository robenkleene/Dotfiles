# Start abbrevations here so they can be added to later
set -U fish_user_abbreviations 'g=git'

# Environment Variables
set -x PATH /usr/local/bin ~/Development/Scripts/bin $PATH

# Editor
set -x EDITOR vim

# Git Editor
# set -x GIT_EDITOR "vim +startinsert"

# Facebook Path Picker
# Don't let `fpp` open files in splits
# Ugh, this breaks opening with line numbers
set -x FPP_EDITOR "vim "

# rbenv
set PATH $HOME/.rbenv/bin $PATH
set PATH $HOME/.rbenv/shims $PATH
rbenv rehash >/dev/null ^&1

# nvm-fish-wrapper
set -x NVM_DIR ~/.nvm
source ~/.config/fish/nvm-wrapper/nvm.fish
# This is a hack to get the default nvm alias working for new shells
# it causes a window to load slowly, all that xargs stuff when creating
# a new window is caused by this. I can try removing it when there's a new
# version of `nvm-wrapper`
# if status --is-login
# 	if test -f ~/.config/fish/nvm-wrapper/nvm.fish
# 		if test (nvm current) = none -a -n (nvm alias default)
# 			nvm use default 2>&1 >/dev/null
# 		end
# 	end
# end
# Temporary solution for above
function nvm-use-default
  nvm use default
end
set fish_user_abbreviations $fish_user_abbreviations 'nud=nvm use default'

# Emacs
# Start the server in the background if it isn't running
set -x ALTERNATE_EDITOR ""
# Open Emacsclient
function ec
  emacsclient -t $argv
end
# Test if server is running
function is-emacs-server-running
  ps -u $USER | grep 'emacs --daemon' | grep --silent -v grep
end
# Display a greeting message if the server is running
if is-emacs-server-running
  set fish_greeting "Emacs server is running"
else
  set fish_greeting
end
# Choose file to open with fzf
function ec-fzf
  sh -c "emacsclient -t \$(/usr/local/bin/fzf)"
end

# Vim
set fish_user_abbreviations $fish_user_abbreviations 'vp=vimpager'
function gvim-pipe
  sh -c "cat | vim -g - > /dev/null 2>&1"
end
# Choose file to open with fzf
function vim-fzf
  sh -c "vim \$(/usr/local/bin/fzf)"
end
# Open unmerged files
function vim-open-unmerged
  sh -c "vim \$(git diff --name-only --diff-filter=U)"
end



# Magit
# function magit
# 	emacs --eval "(rk-magit-status-startup)"
# end
# function gc
# 	emacsclient -c -n --eval "(rk-magit-status-startup)"
# end
function emacs-stop-server
  emacsclient -e '(kill-emacs)'
end

# Atom
set -x ATOM_PATH $HOME/Applications/
set -x ATOM_REPOS_HOME $HOME/Development/Projects/Atom

# Coffeelint
set -x COFFEELINT_CONFIG $HOME/.coffeelint.json

# Edit Dotfiles
set -x FISH_CONFIG_PATH $HOME/Dotfiles/config/fish/config.fish
set fish_user_abbreviations $fish_user_abbreviations 'edf=EDITOR $FISH_CONFIG_PATH'

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
set fish_user_abbreviations $fish_user_abbreviations 'gs=git status'
set fish_user_abbreviations $fish_user_abbreviations 'gd=git diff'
set fish_user_abbreviations $fish_user_abbreviations 'gdt=git difftool'
set fish_user_abbreviations $fish_user_abbreviations 'gdn=git diff --name-only'
set fish_user_abbreviations $fish_user_abbreviations 'gdm=git diff | mate'
set fish_user_abbreviations $fish_user_abbreviations 'ga=git add'
set fish_user_abbreviations $fish_user_abbreviations 'gb=git branch'
set fish_user_abbreviations $fish_user_abbreviations 'gbd=git branch -d'
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

function git-diff-files-added-since-commit
  git diff --name-only HEAD $argv[1]
end

function git-log-name-only
  git log --name-only
end

function git-checkout-branch-origin
  git checkout -b $argv[1] origin/$argv[1]
end

function git-push-origin-delete
  git push origin --delete $argv[1]
end

function git-difftool-commit-minus-one
  git difftool $argv[1] $argv[1]~1
end

function git-remote-remove-origin
  git remote rm origin
end

function git-remote-add-origin
  git remote add origin $argv
end

function git-diff-binary-as-text
  git diff --text $argv
end

function git-log-unpushed-commits
  git log @\{u\}..
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

# Navigation
function o
  open .
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
function r
  ranger-cd
end


# Misc
function cleanopenwith
  /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
end

function cbp
  pbpaste | less
end

# Ack
# Note Ack only ever searches source code files, to search all files use find
function ack-match-filename
  ack -g $argv
end

# Find
function find-filename
  find . -not -path '*.git*' -name "$argv[1]"
end

# BBEdit
function bbf
  bbfind --grep --gui $argv .
end

function bbff
  bbfind --grep --gui --case-sensitive --name-pattern "$argv[1]" "$argv[2]" .
end


# wcsearch
# function sea
#   wcsearch $argv
# end

# This doesn't work, might have hung
# function tpvim
#     tee /dev/tty | sh -c "cat | vim -g - > /dev/null 2>&1"
# end

# Highlight
function hl
  highlight -O ansi "$argv[1]"
end

