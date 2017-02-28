#!/usr/bin/env fish

set --erase fish_user_abbreviations

# Destructive, don't abbreviate or alias
# `git-push-force`
# `git stash`
# `git-reset`
# `git tag --delete`
# `git checkout -- .`

# Bug
abbr -a exit='exiting'

# Basic
abbr -a -- - 'cd -'

# vim
abbr -a v="$VIM_COMMAND"

# ack
abbr -a a="$ACK_COMMAND"
abbr -a av='ack-vim' 
abbr -a af='fzf-ack-vim' 

# emacs
abbr -a e="$EMACS_COMMAND"
abbr -a ec='emacsclient -t' 

# tig
abbr -a tst='tig stash'

# tmux
abbr -a ta='tmux-attach'
abbr -a tmsw='tmux swap-window -t'
abbr -a t='tmux' 

# vim
abbr -a vss='vim-server-start'
abbr -a vse='vim-server-edit'

# grep
abbr -a G='grep'

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
