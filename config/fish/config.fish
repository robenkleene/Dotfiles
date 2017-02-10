# Configuration

# Setup `fisher` (fisherman)
# Install via `brew`, then fun `fisher` in the same directory as the `fishfile`

# fzf
source ~/.config/fish/fzf.fish

# local fish config
if test -e ~/.config.fish
  source ~/.config.fish
end

# Greeting
set --erase fish_greeting

# Path
set -x PATH /usr/local/bin ~/Development/Scripts/bin $PATH
if not test (uname) = Darwin
  set -x PATH ~/bin $PATH
end
# Manpager
set -x PAGER "less --squeeze-blank-lines --ignore-case"

# Pager
set -x PAGER "less --ignore-case"
# Fish
set -x FISH_CONFIG_PATH $HOME/.config/fish/config.fish

# chruby
source /usr/local/share/chruby/chruby.fish
# Maybe one day the below will work:
# bass source /usr/local/share/chruby/chruby.sh
chruby ruby-2.4.0

# nvm
# Relies on `bass` as a dependency
function nvm
  bass source ~/.nvm/nvm.sh ';' nvm $argv
end
function nvm-use-default
  nvm use default
end
set PATH $HOME/.nvm/versions/node/v7.5.0/bin $PATH

# Editor
# Vim
# set -x EDITOR vim
# NeoVim
set -x EDITOR nvim
function vim-edit
  # Vim
  # vim $argv
  # NeoVim
  if test -n "$NVIM_LISTEN_ADDRESS"
    nvimedit $argv
  else
    nvim $argv
  end
end

# Clipboard
if test (uname) = Darwin
  # Piping to a function breaks on interactive commands, so use the `safecopy`
  # script instead. These can be reverted if this bug is resolved.
  # [Can't read pipe to function · Issue #206 · fish-shell/fish-shell](https://github.com/fish-shell/fish-shell/issues/206)
  alias paste-command "pbpaste"
  # alias copy-command "pbcopy"
  # alias copy-find-command "pbcopy -pboard find"
else
  alias paste-command "echo ''"
  # `true` is no-op in this case
  # alias copy-command "true"
  # alias copy-find-command "true"
end

# Colors
set -xg fish_color_search_match black --background=cyan

# Prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set fish_color_comment 3a3a3a
function fish_prompt
  # Note this function will be built-in in fish `2.5`
  # After upgrading remove it and replace with `prompt_hostname`
  if not set -q __prompt_hostname
    set -g __prompt_hostname (hostname|cut -d . -f 1)
  end
  set_color $fish_color_comment
  echo -n (date "+%I:%M %p")
  echo -n ' '
  echo -n $USER@$__prompt_hostname
  echo -n ' '
  set_color $fish_color_cwd
  echo -n (prompt_pwd)
  set_color normal
  echo -n '> '
end
function fish_right_prompt
  echo -n (__fish_git_prompt)
end

# ag
alias ag "ag --path-to-ignore ~/.ignore"

# rg
alias rg "rg --smart-case --line-number"

# Atom
set -x ATOM_PATH $HOME/Applications/
set -x ATOM_REPOS_HOME $HOME/Development/Projects/Atom

# Coffeelint
set -x COFFEELINT_CONFIG $HOME/.coffeelint.json

# mitmproxy
# Supposedly these can be set in a `~/.mitmproxy/config.yaml`, it wasn't
# working with:
# palette_transparent: true
# no_mouse: true
alias mitmproxy "mitmproxy --no-mouse --palette-transparent"

# # Emacs
# Start the server in the background if it isn't running
set -x ALTERNATE_EDITOR ""
# Emacs
function emacs-edit
  # Emacs
  # emacs $argv
  # Emacsclient
  emacsclient -t $argv
end
alias e 'emacs-edit'
function magit
 emacs-edit -eval "(robenkleene/magit-status-startup)"
end
alias m 'magit'

# Homebrew
set -x HOMEBREW_NO_ANALYTICS 1

# Startup

# Emacs
# Test if server is running
function is-emacs-server-running
  ps -u $USER | grep 'emacs --daemon' | grep --silent -v grep
end
# Display a greeting message if the server is running
if is-emacs-server-running
  echo Emacs server is running
else
end
function emacs-kill-server
  emacsclient -e '(kill-emacs)'
end

# tmux
# Echo running sessions if there are any
if tmux ls >/dev/null 2>/dev/null
  # Only echo if we aren't already in a tmux session
  if test -z "$TMUX"
    echo tmux sessions
    tmux ls
  end
end


# Functions
# Quick
function a
  # ag
  # ag $argv
  # rg
  rg $argv
end
function af
  rg --files -g $argv
end
function fa
  fzf-ack-vim $argv
end
function va
  vim-pipe-grep $argv
end
function n
  new-terminal-here
end
function o
  new-finder-window-here
end
function r
  ranger-cd
end
function t
  tmux $argv
end
# Disallowed in fish 2.5.0
# function -
#   cd -
# end
function ts
  tig status +3
end
function ec
  emacsclient -t $argv
end
function v
  vim-edit $argv
end
# fzf
function f
  fzf-file-vim
end
function d
  fzf-directory-cd
end
function fcd
  fzf-directory-cd
end
function fh
  fzf-history-cd
end
function fx
  fzf-project-xcode
end

# Fish
function fish-edit-config
 cd (dirname $FISH_CONFIG_PATH)
 vim-edit $FISH_CONFIG_PATH
end
function fish-edit-abbreviations
 cd (dirname $FISH_CONFIG_PATH)
 vim-edit abbreviations.fish
end
function fish-sync-abbreviations
  ~/.config/fish/abbreviations.fish
end
function fish-sync-history
  history merge
end

# Vim
function vim-restore-session
  vim-edit -c "RestoreSession"
end
function vim-clipboard
  paste-command | vim-edit -
end
function vim-pipe-grep
  # A more portable solution:
  # vim-edit -c "setlocal buftype=nofile bufhidden=hide noswapfile" -c "cbuffer" -c "cw"
  if [ $argv[1] ]
    # Set the search register and the yank register
    rg $argv --with-filename | vim-edit -c "GrepBuffer" -c "let @/='\v$argv[-1]' | let @0=@* | set hlsearch" -
    # ag $argv | vim-edit -c "GrepBuffer" -c "let @/='\v$argv[-1]' | let @0=@* | set hlsearch" -
  else
    # If there's no argument, assume results are being piped in
    vim-edit -c "GrepBuffer" -
  end
end
# This doesn't work because default `ack` output doesn't include filename
# on the line.
# function vim-pipe-grep-clipboard
#   paste-command | vim-edit -c "GrepBuffer" -c "let @/='\v$argv[-1]' | let @0=@* | set hlsearch" -
# end
function git-vim-modified
  vim-edit (git diff --name-only --diff-filter=U | uniq)
end
function git-clean-checkout
  git clean -dff; and git checkout -- .
end
function git-submodule-update-init-recursive
  git submodule update --init --recursive
end
function git-submodule-clean-checkout
  git submodule foreach --recursive 'git clean -dff && git checkout -- .'
end
function git-reset
  git-clean-checkout
  git-submodule-reset
end
function git-submodule-reset
  git submodule update --init --recursive
  git submodule foreach --recursive 'git clean -dff && git checkout -- .'
end

# Git
if test (uname) = Darwin
  function git-reveal-diff
    git diff --name-only -z | xargs -0 open -R
  end
end
function git-diff-words
  git diff --color-words
end
function git-copy-branch
  git rev-parse --abbrev-ref HEAD | tee /dev/tty | tr -d '\n' | safecopy
end
function git-copy-commit-hash
  # Print the '\n' because otherwise `tmux` has issues
  git rev-parse HEAD | tee /dev/tty | tr -d '\n' | safecopy
end
function git-commit-hash
  # Print the '\n' because otherwise `tmux` has issues
  git rev-parse HEAD
end
function git-cd-root
  cd (git rev-parse --show-toplevel)
end
function git-push-branch-origin
  git push --set-upstream origin (git rev-parse --abbrev-ref HEAD)
end
function git-push-origin-delete
  git push origin --delete $argv[1]
end
function git-branch-delete-origin
  git push origin --delete $argv[1]
end
function git-remote-url
  git remote --verbose
end
function git-copy-remote-url
  git ls-remote --get-url | tr -d '\n' | tee /dev/tty | safecopy
end
function git-remote-add-origin
  git remote rm origin
  git remote add origin $argv[1]
end
function git-prune-remote-origin
  git remote prune origin
end
function git-prune
  git-prune-remote-origin
end
function git-log-unpushed-commits
  git log @\{u\}..
end
function git-diff-dirty
  git diff --name-only --diff-filter=UM
end
# Open unmerged files in Vim
function git-vim-dirty
  sh -c "vim-edit \$(git diff --name-only --diff-filter=UM)"
end
function git-difftool-commit-minus-one
  git difftool $argv[1]^!
end
function git-diff-commit-minus-one
  git diff $argv[1]^!
end
function git-push-force
  git push --force-with-lease
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
function git-stash-list
  git stash list
end

# tmux
function tmux-session-test
  if test -z "$TMUX"
    echo "tmux is not running"
   return
  end
  tmux split-window -l 10
  tmux new-window
  tmux next-window
  tmux select-pane
end

function tmux-documentation
  if test -n "$TMUX"
    tmux split-window -c ~/Documentation/development-references/Tmux/
  else 
    cd ~/Documentation/development-references/Tmux/
  end
end
function tmux-name-directory
  tmux rename-window (basename (pwd))
end
function tmux-attach
  if [ $argv[1] ]
    tmux attach -t $argv
  else
    tmux attach
  end
end

# egit
function egitn
  set EGITNEXT (egit -n)
  if test -n "$EGITNEXT"
    cd "$EGITNEXT"
    git status
  end
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

# Misc
function cd-copy-path
  pwd | tr -d '\n' | safecopy
end

# BBEdit
if test (uname) = Darwin
  function bbfind-gui-grep-case
    bbfind --grep --gui --case-sensitive $argv .
  end
  function bbfind-gui-grep
    bbfind --grep --gui $argv .
  end
  function bbfind-gui-grep-case-name
    bbfind --grep --gui --case-sensitive --name-pattern "$argv[1]" "$argv[2]" .
  end
  function bbedit-pipe-grep
    if [ $argv[1] ]
      echo $argv | tr -d '\n' | safecopy -pboard find
      # Insert a space after the line number, this is because `bbresults`
      # input requires a space there
      rg --column $argv | bbresults --pattern grep --new-window
    else
      # If there's no argument, assume results are being piped in
      bbresults --pattern grep --new-window
    end
  end
end

# Gem
function gem-update-no-doc
  gem update --no-ri --no-rdoc
end

# Jekyll
function jekyll-build-watch
  bundle exec jekyll build --watch
end
function jekyll-build-watch-drafts
  bundle exec jekyll build --watch --drafts
end
function jekyll-serve-watch
  # The `--open-url` version isn't supported by `gh-pages` jekyll yet
  bundle exec jekyll serve --watch
end
function jekyll-serve-watch-drafts
  # The `--open-url` version isn't supported by `gh-pages` jekyll yet
  bundle exec jekyll serve --watch --drafts
end

# Carthage
function carthage-submodule-bootstrap
  carthage bootstrap --use-submodules --no-use-binaries $argv
end
function carthage-submodule-update
  carthage update --use-submodules --no-use-binaries $argv
end

# ssh
function ssh-start
  eval (ssh-agent -c)
  ssh-add
end

# Web Console

# wcsearch
# function sea
#   wcsearch $argv
# end

function edit_cmd --description 'Input command in external editor'
  set tempfile (mktemp /tmp/fish.cmd.XXXXXXXX)
  and test -n "$tempfile"
  and set cursorposition (commandline -C)
  and commandline -b > $tempfile
  and vim-edit -c 'set ft=fish' $tempfile
  and set edited (cat $tempfile)
  and test -n "$edited"
  and commandline -r $edited
  and commandline -C $cursorposition
  and command rm $tempfile
end

function fish_user_key_bindings
  # Better binding but I can't get this to work
  # bind \cx\ce 'edit_cmd'
  bind \ee 'edit_cmd'
end
