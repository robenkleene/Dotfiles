# ranger
function ranger-cd() {
  local tempfile='/tmp/chosendir'
  ranger --choosedir="$tempfile" "${@:-$(pwd)}"
  test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
      cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}

# egitn
function egitn() {
  local egitnext=$(egit -n)
  if [ -n "$egitnext" ]; then
    cd "$egitnext"
    git status
  fi
}

# vim
function vim-edit() {
  if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    nvimedit $@
  else
    nvim $@
  fi
}
function vim-restore-session() {
  vim-edit -c "RestoreSession"
}
function vim-pipe-grep() {
  if [ $# -gt 0 ]; then
    # Set the search register and the yank register
    local setup_system_clipboard=""
    if [ "$(uname)" = "Darwin" ]; then
      setup_system_clipboard="| let @0=@*"
    fi
    rg --smart-case --line-number --with-filename $@ | vim-edit -c "GrepBuffer" -c "let @/='\v${@: -1}' $setup_system_clipboard | set hlsearch" -
  else
    vim-edit -c "GrepBuffer" -
  fi
}

# Emacs
function emacs-edit() {
  emacsclient -t $@
}
function magit() {
  emacs-edit -eval "(robenkleene/magit-status-startup)"
}

# ssh
function ssh-start() {
  eval `ssh-agent -c`
  ssh-add
}

# zsh
function zsh-edit-config() {
  cd ~/Development/Dotfiles/
  vim-edit zshrc
}


# neovim
function vim-server-start() {
  if [ -z "$TMUX" ]; then
    NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim $@
  else
    nvim_session_id=$(tmux display-message -p '#{session_id}')
    NVIM_LISTEN_ADDRESS=/tmp/nvimsocket$nvim_session_id nvim $@
  fi
}
function vim-server-edit() {
  if [ -z "$TMUX" ]; then
    nvr $@
  else
    nvim_session_id=$(tmux display-message -p '#{session_id}')
    nvr --servername /tmp/nvimsocket$nvim_session_id $argv
  fi
}

# tmux
function tmux-default-command() {
  if [ "$(uname)" = "Darwin" ]; then
    tmux set-option default-command "reattach-to-user-namespace -l $1"
  else
    tmux set-option default-shell $1
  fi
}
function tmux-default-fish() {
  tmux-default-command $(which fish)
}
function tmux-default-zsh() {
  tmux-default-command $(which zsh)
}
function tmux-name-directory() {
  tmux rename-window $(basename $PWD)
}
function tmux-attach() {
  if [ $# -eq 1 ]; then
    tmux attach -t $argv
  else
    tmux attach
  fi
}

# git
function git-vim-modified() {
  vim-edit $(git diff --name-only --diff-filter=U | uniq)
}
function git-checkout-modified() {
  git checkout -- .
}
function git-clean-checkout() {
  git clean -dff && git checkout -- .
}
function git-submodule-update-init-recursive() {
  git submodule update --init --recursive
}
function git-submodule-clean-checkout() {
  git submodule foreach --recursive 'git clean -dff && git checkout -- .'
}
function git-reset() {
  git-clean-checkout
  git-submodule-reset
}
function git-submodule-reset() {
  git submodule update --init --recursive
  git submodule foreach --recursive 'git clean -dff && git checkout -- .'
}
if [ "$(uname)" = "Darwin" ]; then
  function git-reveal-diff() {
    git diff --name-only -z | xargs -0 open -R
  }
fi
function git-diff-words() {
  git diff --color-words
}
function git-copy-branch() {
  git rev-parse --abbrev-ref HEAD | tee /dev/tty | tr -d '\n' | safecopy
}
function git-copy-commit-hash() {
  # Print the '\n' because otherwise `tmux` has issues
  git rev-parse HEAD | tee /dev/tty | tr -d '\n' | safecopy
}
function git-commit-hash() {
  git rev-parse HEAD
}
function git-cd-root() {
  cd $(git rev-parse --show-toplevel)
}
function git-push-branch-origin() {
  git push --set-upstream origin (git rev-parse --abbrev-ref HEAD)
}
function git-push-origin-delete() {
  git push origin --delete $1
}
function git-branch-delete-origin() {
  git push origin --delete $1
}
function git-remote-url() {
  git remote --verbose
}
function git-copy-remote-url() {
  git ls-remote --get-url | tr -d '\n' | tee /dev/tty | safecopy
}
function git-remote-add-origin() {
  git remote rm origin
  git remote add origin $1
}
function git-prune-remote-origin() {
  git remote prune origin
}
function git-prune() {
  git-prune-remote-origin
}
function git-push-force() {
  git push --force-with-lease
}

# Git Stash
function git-stash-command() {
  local stash_command="git stash $1"
  if [ $# -gt 1 ]; then
    stash_command="$stash_command stash@\{$2\}"
  fi
  eval $stash_command
}
function git-stash-pop() {
  git-stash-command "pop" $1
}
function git-stash-apply() {
  git-stash-command "apply" $1
}
function git-stash-show() {
  git-stash-command "show" $1
}
function git-stash-diff() {
  git-stash-command "show --patch" $1
}
function git-stash-drop() {
  git-stash-command "drop" $1
}
function git-stash-list() {
  git stash list
}

# Misc
function cd-copy-path() {
  pwd | tr -d '\n' | safecopy
}

# Gem
function gem-update-no-doc() {
  gem update --no-ri --no-rdoc
}

# Jekyll
function jekyll-build-watch() {
  bundle exec jekyll build --watch
}
function jekyll-build-watch-drafts() {
  bundle exec jekyll build --watch --drafts
}
function jekyll-serve-watch() {
  # The `--open-url` version isn't supported by `gh-pages` jekyll yet
  bundle exec jekyll serve --watch
}
function jekyll-serve-watch-drafts() {
  # The `--open-url` version isn't supported by `gh-pages` jekyll yet
  bundle exec jekyll serve --watch --drafts
}

# Carthage
function carthage-submodule-bootstrap() {
  carthage bootstrap --use-submodules --no-use-binaries $argv
}
function carthage-submodule-update() {
  carthage update --use-submodules --no-use-binaries $argv
}
