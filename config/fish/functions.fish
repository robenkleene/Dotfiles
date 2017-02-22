# Emacs
function emacs-edit
  # Emacs
  # emacs $argv
  # Emacsclient
  emacsclient -t $argv
end
function magit
 emacs-edit -eval "(robenkleene/magit-status-startup)"
end

# Fish
function fish-edit-config
 cd (dirname $FISH_CONFIG_PATH)
 vim-edit $FISH_CONFIG_PATH
end
function fish-edit-abbreviations
 cd (dirname $FISH_CONFIG_PATH)
 vim-edit abbr.fish
end
function fish-sync-abbreviations
  ~/.config/fish/abbr.fish
end
function fish-sync-history
  history merge
end
function exiting
  # Workaround because `fasd` always runs a background process and fish warns
  # before quitting if there's a background process. Occassionally try removing
  # this and see if the `fasd` plugin has resolved the problem itself.
  # abbr -a exit='functions --erase __fasd_run; sleep 0.1; and exit; and clear'
  if test (jobs | wc -l) -eq 1; and jobs | grep --silent "fasd --proc"
    functions --erase __fasd_run; sleep 0.1; and exit;
  else
    exit
  end
end
# Vim
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
function vim-restore-session
  vim-edit -c "RestoreSession"
end
function vim-clipboard
  safepaste | vim-edit -
end
function vim-pipe-grep
  # A more portable solution:
  # vim-edit -c "setlocal buftype=nofile bufhidden=hide noswapfile" -c "cbuffer" -c "cw"
  if [ $argv[1] ]
    # Set the search register and the yank register
    set setup_system_clipboard ""
    if test (uname) = Darwin
      set setup_system_clipboard "| let @0=@*"
    end
    rg $argv --with-filename | vim-edit -c "GrepBuffer" -c "let @/='\v$argv[-1]' $setup_system_clipboard | set hlsearch" -
    # ag $argv | vim-edit -c "GrepBuffer" -c "let @/='\v$argv[-1]' | let @0=@* | set hlsearch" -
  else
    # If there's no argument, assume results are being piped in
    vim-edit -c "GrepBuffer" -
  end
end

# neovim
function vim-server-start
  if test -z "$TMUX"
    env NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim $argv
  else
    set nvim_session_id (tmux display-message -p '#{session_id}')
    env NVIM_LISTEN_ADDRESS=/tmp/nvimsocket$nvim_session_id nvim $argv
  end
end
function vim-server-edit
  if test -z "$TMUX"
    nvr $argv
  else
    set nvim_session_id (tmux display-message -p '#{session_id}')
    nvr --servername /tmp/nvimsocket$nvim_session_id $argv
  end
end

# tmux
function tmux-default-command
  if test (uname) = Darwin
    tmux set-option default-command "reattach-to-user-namespace -l $argv[1]"
  else
    tmux set-option default-shell $argv[1]
  end
end
function tmux-default-fish
  tmux-default-command (which fish)
end
function tmux-default-zsh
  tmux-default-command (which zsh)
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

# git

# This doesn't work because default `ack` output doesn't include filename
# on the line.
# function vim-pipe-grep-clipboard
#   safepaste | vim-edit -c "GrepBuffer" -c "let @/='\v$argv[-1]' | let @0=@* | set hlsearch" -
# end
function git-vim-modified
  vim-edit (git diff --name-only --diff-filter=U | uniq)
end
function git-checkout-modified
  git checkout -- .
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

