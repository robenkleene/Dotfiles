# Fisherman
# To setup, install fisherman and plugins:
# bass
# fasd
set fisher_home ~/.local/share/fisherman
set fisher_config ~/.config/fisherman
source $fisher_home/config.fish

# Clear Greating
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

# nvm
# Relies on `bass` as a dependency
function nvm
  bass source ~/.nvm/nvm.sh ';' nvm $argv
end
function nvm-use-default
  nvm use default
end
set PATH $HOME/.nvm/versions/node/v0.12.2/bin $PATH

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
function gvim-pipe
  sh -c "cat | vim -g - > /dev/null 2>&1"
end
function vim-pipe-grep
  # A more portable solution:
  # vim -c "setlocal buftype=nofile bufhidden=hide noswapfile" -c "cbuffer" -c "cw"
  vim -c "GrepBuffer" -
end
function vim-git-modified
  vim (git ls-files -m)
end
# pbpaste Vim

# fzf
function fzf-cd
  find * -type d | fzf  > $TMPDIR/fzf.result
  [ (cat $TMPDIR/fzf.result | wc -l) -gt 0 ]
  and cd (cat $TMPDIR/fzf.result)
  commandline -f repaint
  rm -f $TMPDIR/fzf.result
end
# cd to bookmark
set -x RKBOOKMARKS ~/Dotfiles/ ~/Development/ ~/Development/Scratch/ ~/Development/Scratch/Temp/ ~/Development/Projects/ ~/Dropbox/Text/
function fzf-cd-bookmark
  printf '%s\n' $RKBOOKMARKS | fzf  > $TMPDIR/fzf.result
  [ (cat $TMPDIR/fzf.result | wc -l) -gt 0 ]
  and cd (cat $TMPDIR/fzf.result)
  commandline -f repaint
  rm -f $TMPDIR/fzf.result
end
# fzf emacs
function fzf-ec
  sh -c "emacsclient -t \"\$(/usr/local/bin/fzf)\""
end
# fzf vim
function fzf-vim
  sh -c "vim \"\$(/usr/local/bin/fzf)\""
end
function fzf-lines-vim
  ag --nocolor --nobreak --noheading "[a-zA-Z0-9]+" . | fzf > $TMPDIR/fzf.result
  if [ (cat $TMPDIR/fzf.result | wc -l) -gt 0 ]
    cat $TMPDIR/fzf.result | vim -c "GrepBuffer" -
  end
  rm -f $TMPDIR/fzf.result
end

# fzf snippets
function fzf-snippet
  sh -c "cat ~/Development/Snippets/\$(cd ~/Development/Snippets/; find * -type f | /usr/local/bin/fzf) | tee /dev/tty | pbcopy"
end

# fzf mate
function fzf-mate
  sh -c "mate \"\$(/usr/local/bin/fzf)\""
end
# fzf reveal
function fzf-reveal
  sh -c "open -R \"\$(/usr/local/bin/fzf)\""
end
function fzf-open
  sh -c "open \"\$(/usr/local/bin/fzf)\""
end
# fzf git
function fzf-git-reveal-diff
  git diff --name-only | fzf | tr '\n' '\0' | xargs -0 open -R
end
# fzf Xcode
function fzf-xcode
  find . -path '*.xcodeproj' -prune -o -name '*.xcworkspace' -o -name '*.xcodeproj' | fzf | tr '\n' '\0' | xargs -0 open
end

# Find

# Atom
set -x ATOM_PATH $HOME/Applications/
set -x ATOM_REPOS_HOME $HOME/Development/Projects/Atom

# Coffeelint
set -x COFFEELINT_CONFIG $HOME/.coffeelint.json

# Edit Dotfiles
set -x FISH_CONFIG_PATH $HOME/Dotfiles/config/fish/config.fish

# Prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow

set fish_color_comment 3a3a3a

# Prompt
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
function git-reveal-diff
  git diff --name-only -z | xargs -0 open -R
end

function git-push-branch-origin
  git push --set-upstream origin (git rev-parse --abbrev-ref HEAD)
end

function git-remote-add-origin
  git remote rm origin
  git remote add origin $argv[1]
end

function git-remote-prune-origin
  git remote prune origin
end

function git-difftool-commit-minus-one
  git difftool $argv[1]^!
end

function git-log-unpushed-commits
  git log @\{u\}..
end

function git-diff-dirty
  git diff --name-only --diff-filter=UM
end

# Git Stash
function git-stash-command
  set cmd[1] "git stash $argv[1]"
  set -e argv[1]
  if [ $argv[1] ]
    set cmd $cmd stash@\\\{$argv[1]\\\}
    set -e argv[1]
    set cmd $cmd $argv
  end
  eval $cmd
end

function git-stash-pop
  git-stash-command "pop" $argv
end

function git-stash-apply
  git-stash-command "apply" $argv
end

function git-stash-show
  git-stash-command "show" $argv
end

function git-stash-diff
  git-stash-command "show --patch" $argv
end

function git-stash-drop
  git-stash-command "drop" $argv
end

# Open unmerged files in Vim
function git-vim-dirty
  sh -c "vim \$(git diff --name-only --diff-filter=UM)"
end

function git-difftool-commit-minus-one
  git difftool $argv[1] $argv[1]~1
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

# Navigation
function o
  new-finder-window-here
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

# Gem
function gem-update-no-doc
  gem update --no-ri --no-rdoc
end

# Jekyll
function jekyll-serve-drafts
  bundle exec jekyll serve --drafts
end
function jekyll-build-watch-drafts
  bundle exec jekyll build --watch --drafts
end
function jekyll-serve
  bundle exec jekyll serve
end
function jekyll-build-watch
  bundle exec jekyll build --watch
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
