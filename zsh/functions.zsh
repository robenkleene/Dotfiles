# Private

_robenkleene_ack_lines() {
  rg --no-heading --smart-case --line-number --with-filename $@
}
_robenkleene_ack_lines_color() {
  _robenkleene_ack_lines --color=always $@
}
_robenkleene_ack_lines_no_color() {
  _robenkleene_ack_lines --color=never $@
}

# Commands

# ranger
ranger-cd() {
  local tempfile='/tmp/chosendir'
  ranger --choosedir="$tempfile" "${@:-$(pwd)}"
  test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
      cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}

# egitn
egitn() {
  local egitnext=$(egit -n)
  if [ -n "$egitnext" ]; then
    cd "$egitnext"
    git status
  fi
}

# vim
vim-session-restore-saved() {
  $VIM_COMMAND -c "SessionRestoreSaved"
}
vim-session-restore-local() {
  $VIM_COMMAND -c "SessionRestoreLocal"
}
vim-session-restore-auto() {
  $VIM_COMMAND -c "SessionRestoreAuto"
}
vim-grep() {
  $VIM_COMMAND -c "GrepBuffer" -
}
vim-git-modified() {
  $VIM_COMMAND $(git diff --name-only --diff-filter=UM | uniq)
}
vim-git-conflicts() {
  $VIM_COMMAND $(git diff --name-only --diff-filter=UM | uniq) -c "vimgrep /======/ ##"
}
vim-diff-grep() {
  diff-to-grep | vim-grep
}
vim-git-diff() {
  git diff --relative $argv | vim-diff-grep
}
vim-todo() {
  if [ -n "$TODO_FILE" ]; then
    $VIM_COMMAND $TODO_FILE
  elif [ -n "$TODO_DIRECTORY" ]; then
    eval $VIM_COMMAND $TODO_DIRECTORY
  else
    echo '$TODO_DIRECTORY is undefined or empty'
  fi
}


# Emacs
magit() {
  eval "$EMACS_COMMAND -eval \"(robenkleene/magit-status-startup)\""
}
emacs-kill-server() {
  emacsclient -e '(kill-emacs)'
}

# ssh
ssh-start() {
  eval `ssh-agent -s`
  ssh-add
}

# Fix slow ssh
if [ ! "$(uname)" = "Darwin" ]; then
  ssh-fix() {
    sudo systemctl restart systemd-logind 
  }
fi

# zsh
zsh-edit-config() {
  cd ~/Development/Dotfiles/zsh/
  eval $EDITOR ../zshrc
}


# neovim
vim-server-start() {
  if [ -z "$TMUX" ]; then
    NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim $@
  else
    nvim_session_id=$(tmux display-message -p '#{session_id}')
    NVIM_LISTEN_ADDRESS=/tmp/nvimsocket$nvim_session_id nvim $@
  fi
}
vim-server-edit() {
  if [ -z "$TMUX" ]; then
    nvr $@
  else
    nvim_session_id=$(tmux display-message -p '#{session_id}')
    nvr --servername /tmp/nvimsocket$nvim_session_id $argv
  fi
}

# tmux
_robenkleene_tmux_default_command() {
  if [ "$(uname)" = "Darwin" ]; then
    tmux set-option default-command "reattach-to-user-namespace -l $1"
  else
    tmux set-option default-shell $1
  fi
}
tmux-default-fish() {
  _robenkleene_tmux_default_command $(which fish)
}
tmux-default-zsh() {
  _robenkleene_tmux_default_command $(which zsh)
}
tmux-name-directory() {
  tmux rename-window "$(basename $PWD)"
}
tmux-attach() {
  if [ $# -eq 1 ]; then
    tmux attach -t $argv
  else
    tmux attach
  fi
}

# git
git-checkout-modified() {
  git checkout -- .
}
git-clean-checkout() {
  git clean -dff && git checkout -- .
}
git-submodule-update-init-recursive() {
  git submodule update --init --recursive
}
git-submodule-clean-checkout() {
  git submodule foreach --recursive 'git clean -dff && git checkout -- .'
}
git-reset() {
  git-clean-checkout
  git-submodule-reset
}
git-reset-soft() {
  git reset --soft "HEAD^"
}
git-submodule-reset() {
  git submodule update --init --recursive
  git submodule foreach --recursive 'git clean -dff && git checkout -- .'
}
if [ "$(uname)" = "Darwin" ]; then
  git-reveal-diff() {
    git diff --name-only -z | xargs -0 open -R
  }
fi
git-diff-words() {
  git diff --color-words $@
}
# Branch
git-branch-print() {
  git rev-parse --abbrev-ref HEAD | tr -d '\n' | tee /dev/tty | safecopy
}
# git-branch-yank() {
#   git rev-parse --abbrev-ref HEAD | tr -d '\n'
# }
# Hash
git-hash-print() {
  git rev-parse HEAD | tr -d '\n'
}
# git-hash-yank() {
#   git rev-parse HEAD | tr -d '\n' | tee /dev/tty | safecopy
# }
# Remote
git-remote-print() {
  git ls-remote --get-url | tr -d '\n'
}
# git-remote-yank() {
#   git ls-remote --get-url | tr -d '\n' | tee /dev/tty | safecopy
# }
git-commit-hash() {
  git rev-parse HEAD
}
git-root() {
  git rev-parse --show-toplevel
}
git-cd-root() {
  cd "$(git rev-parse --show-toplevel)"
}
git-push-branch-origin() {
  git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)
}
git-push-origin-delete() {
  git push origin --delete $1
}
git-branch-delete-origin() {
  git push origin --delete $1
}
git-remote-add-origin() {
  git remote rm origin
  git remote add origin $1
}
git-prune-remote-origin() {
  git remote prune origin
}
git-prune() {
  git-prune-remote-origin
}
git-push-force() {
  git push --force-with-lease
}

# Git Stash
_robenkleene_git_stash_command() {
  local stash_command="git stash $1"
  if [ $# -gt 1 ]; then
    stash_command="$stash_command stash@\{$2\}"
  fi
  eval $stash_command
}
git-stash-pop() {
  _robenkleene_git_stash_command "pop" $1
}
git-stash-apply() {
  _robenkleene_git_stash_command "apply" $1
}
git-stash-show() {
  _robenkleene_git_stash_command "show" $1
}
git-stash-diff() {
  _robenkleene_git_stash_command "show --patch" $1
}
git-stash-drop() {
  _robenkleene_git_stash_command "drop" $1
}
git-stash-list() {
  git stash list
}

# Misc
cd-yank-path() {
  pwd | tr -d '\n' | tee /dev/tty | safecopy
}
cd-todo() {
  if [ -n "$TODO_DIRECTORY" ]; then
    cd $TODO_DIRECTORY
  else
    echo '$TODO_DIRECTORY is undefined or empty'
  fi
}

# Gem
gem-update-no-doc() {
  gem update --no-ri --no-rdoc
}

# Jekyll
jekyll-build-watch() {
  bundle exec jekyll build --watch
}
jekyll-build-watch-drafts() {
  bundle exec jekyll build --watch --drafts
}
jekyll-serve-watch() {
  # The `--open-url` version isn't supported by `gh-pages` jekyll yet
  bundle exec jekyll serve --watch
}
jekyll-serve-watch-drafts() {
  # The `--open-url` version isn't supported by `gh-pages` jekyll yet
  bundle exec jekyll serve --watch --drafts
}

