set --erase fish_greeting

# Environment Variables
set -x PATH /usr/local/bin ~/Development/Scripts/bin $PATH

# Editor
set -x EDITOR vim

# Git Editor
# Start in insert mode
# set -x GIT_EDITOR "vim +startinsert"

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
abbr -a nud='nvm use default'

# Emacs
# Start the server in the background if it isn't running
set -x ALTERNATE_EDITOR ""
# Emacsclient
function ec
  emacsclient -t $argv
end
# Test if server is running
function is-emacs-server-running
  ps -u $USER | grep 'emacs --daemon' | grep --silent -v grep
end
# Display a greeting message if the server is running
if is-emacs-server-running
  echo Emacs server is running
else
end
function emacs-stop-server
  emacsclient -e '(kill-emacs)'
end

# tmux
# Echo running sessions if there are any
if tmux ls >/dev/null 2>/dev/null
  echo tmux sessions
  tmux ls
end


# Vim
abbr -a vp='vimpager'
function gvim-pipe
  sh -c "cat | vim -g - > /dev/null 2>&1"
end
function vim-pipe-grep
  vim -c "setlocal buftype=nofile bufhidden=hide noswapfile" -c "cbuffer" -
end
abbr -a vpg='vim-pipe-grep'
# pbpaste Vim
abbr -a pbv='pbpaste | vim -'

# fzf
function fzf-cd
  find * -type d | fzf  > $TMPDIR/fzf.result
  [ (cat $TMPDIR/fzf.result | wc -l) -gt 0 ]
  and cd (cat $TMPDIR/fzf.result)
  commandline -f repaint
  rm -f $TMPDIR/fzf.result
end
abbr -a fcd='fzf-cd'
# cd to bookmark
set -x RKBOOKMARKS ~/Dotfiles/ ~/Development/ ~/Development/Scratch/ ~/Development/Scratch/Temp/ ~/Development/Projects/ ~/Dropbox/Text/
function fzf-cd-bookmark
  printf '%s\n' $RKBOOKMARKS | fzf  > $TMPDIR/fzf.result
  [ (cat $TMPDIR/fzf.result | wc -l) -gt 0 ]
  and cd (cat $TMPDIR/fzf.result)
  commandline -f repaint
  rm -f $TMPDIR/fzf.result
end
abbr -a fcd='fzf-cd-bookmark'
# fzf emacs
function fzf-ec
  sh -c "emacsclient -t \"\$(/usr/local/bin/fzf)\""
end
# fzf vim
function fzf-vim
  sh -c "vim \"\$(/usr/local/bin/fzf)\""
end
# fzf mate
function fzf-mate
  sh -c "mate \"\$(/usr/local/bin/fzf)\""
end
abbr -a fm='fzf-mate'
# fzf reveal
function fzf-reveal
  sh -c "open -R \"\$(/usr/local/bin/fzf)\""
end
abbr -a fr='fzf-reveal'
function fzf-open
  sh -c "open \"\$(/usr/local/bin/fzf)\""
end
abbr -a fo='fzf-open'
# fzf git
function fzf-git-reveal-diff
  git diff --name-only | fzf | tr '\n' '\0' | xargs -0 open -R
end
# fzf Xcode
function fzf-xcode
  find . -path '*.xcodeproj' -prune -o -name '*.xcworkspace' -o -name '*.xcodeproj' | fzf | tr '\n' '\0' | xargs -0 open
end
abbr -a fx='fzf-xcode'

# Find
abbr -a fn='find . -name'

# Atom
set -x ATOM_PATH $HOME/Applications/
set -x ATOM_REPOS_HOME $HOME/Development/Projects/Atom

# Coffeelint
set -x COFFEELINT_CONFIG $HOME/.coffeelint.json

# Edit Dotfiles
set -x FISH_CONFIG_PATH $HOME/Dotfiles/config/fish/config.fish
abbr -a edf='EDITOR $FISH_CONFIG_PATH'

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
abbr -a g='git'
abbr -a gs='git status'
abbr -a gd='git diff'
abbr -a gdn='git diff --name-only'
abbr -a gdt='git difftool'
abbr -a ga='git add'
abbr -a gb='git branch'
abbr -a gbd='git branch -d'
abbr -a gm='git merge'
abbr -a gaa='git add --all :/'
abbr -a gp='git push'
abbr -a gu='git pull'
abbr -a gl='git log'
abbr -a gco='git checkout'
abbr -a gcob='git checkout -b'
abbr -a gcot='git checkout --theirs'
abbr -a gc='git commit'
abbr -a gca='git commit --amend'
abbr -a gcm='git commit -m'
abbr -a gcam='git commit --amend -m'
abbr -a gsi='git submodule init'
abbr -a gsu='git submodule update'
abbr -a gur='git pull --rebase'
abbr -a gpbo='git push --set-upstream origin (git rev-parse --abbrev-ref HEAD)'
abbr -a gtl='git stash list'
abbr -a gta='git stash apply'
abbr -a gtp='git stash pop'

function git-reveal-diff
  git diff --name-only -z | xargs -0 open -R
end

function git-push-branch-origin
  git push --set-upstream origin (git rev-parse --abbrev-ref HEAD)
end
abbr -a gpbo='git-push-branch-origin'

function git-checkout-branch-origin
  git checkout -b $argv[1] origin/$argv[1]
end
abbr -a gcobo='git-checkout-branch-origin'

function git-push-origin-delete
  git push origin --delete $argv[1]
end

function git-remote-add-origin
  git remote rm origin
  git remote add origin $argv[1]
end

function git-difftool-commit-minus-one
  git difftool $argv[1] $argv[1]~1
end

function git-log-unpushed-commits
  git log @\{u\}..
end

function git-diff-dirty
  git diff --name-only --diff-filter=UM
end

# Open unmerged files in Vim
function git-vim-dirty
  sh -c "vim \$(git diff --name-only --diff-filter=UM)"
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
abbr -a hb='hub browse'
abbr -a hbc='hub browse -- commits'

# Navigation
function o
  open .
end
function -
  cd -
end
function n
  new-terminal-here
end
function x
  find . -path '*.xcodeproj' -prune -o -name '*.xcworkspace' -o -name '*.xcodeproj' | head -n 1 | tr '\n' '\0' | xargs -0 open
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
  bbfind --grep --gui --case-sensitive $argv .
end

function bbfi
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
