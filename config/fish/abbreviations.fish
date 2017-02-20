#!/usr/bin/env fish

set --erase fish_user_abbreviations

# Destructive, don't abbreviate or alias
# `git-push-force`
# `git stash`
# `git-reset`
# `git tag --delete`

# Basic
abbr -a -- - 'cd -'

# tig
abbr -a tst='tig stash'

# tmux
abbr -a ta='tmux-attach'
abbr -a tmsw='tmux swap-window -t'
abbr -a t='tmux' 

# vim
abbr -a vss='vim-server-start'
abbr -a vse='vim-server-edit'

# git
abbr -a ga='git add'
abbr -a gb='git branch'
abbr -a gbd='git branch --delete'
abbr -a gc='git commit'
abbr -a gcam='git commit --amend -m'
abbr -a gcl='git clone'
abbr -a gcm='git commit -m'
abbr -a gco='git checkout'
abbr -a gcob='git checkout -b'
abbr -a gd='git diff'
abbr -a gdt='git difftool'
abbr -a gl='git log'
abbr -a gm='git merge'
abbr -a gr='git rebase'
abbr -a gsm='git submodule'
abbr -a gsta='git-stash-apply'
abbr -a gstd='git-stash-diff'
abbr -a gstl='git stash list'
abbr -a gstp='git-stash-pop'
abbr -a gsts='git stash save'
abbr -a gstsh='git-stash-show'
abbr -a gt='git tag'
# alias
abbr -a gvm='git-vim-modified'
abbr -a gur='git pull --rebase'
abbr -a gu='git pull'
abbr -a gsmi='git submodule init'
abbr -a gsmu='git submodule update'
abbr -a gs='git status'
abbr -a grc='git rebase --continue'
abbr -a gpt='git push --tags'
abbr -a gp='git push'
abbr -a gf='git fetch'
abbr -a gcom='git checkout -- .'
abbr -a gcd='git-cd-root'
abbr -a gca='git commit --amend'
abbr -a gbr='git branch --remotes'
abbr -a gbpr='git-prune-remote-origin'
abbr -a gprb='git-prune-remote-origin'
abbr -a gaa='git add --all :/'

# hub
if test (uname) = Darwin
  abbr -a hb='hub browse'
  abbr -a hbc='hub browse -- commits'
end
