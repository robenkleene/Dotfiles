#!/usr/bin/env fish

set --erase fish_user_abbreviations

# nvm
abbr -a nud='nvm use default'

# functions
abbr -a vpg='vim-pipe-grep'
abbr -a pbv='pbpaste | vim -'

# Vim
abbr -a vgm='vim-git-modified'

# fzf
abbr -a fcd='fzf-cd'
abbr -a fcd='fzf-cd-bookmark'
abbr -a flv='fzf-lines-vim'
abbr -a fm='fzf-mate'
abbr -a fr='fzf-reveal'
abbr -a fo='fzf-open'
abbr -a fx='fzf-xcode'
abbr -a fb='fzf-cd-bookmark'
abbr -a fv='fzf-vim'
abbr -a fs='fzf-snippet'
abbr -a fsr='fzf-snippet-reveal'

# git
abbr -a g='git'
abbr -a ga='git add'
abbr -a gaa='git add --all :/'
abbr -a gb='git branch'
abbr -a gbd='git branch -d'
abbr -a gc='git commit'
abbr -a gca='git commit --amend'
abbr -a gcam='git commit --amend -m'
abbr -a gcm='git commit -m'
abbr -a gco='git checkout'
abbr -a gcob='git checkout -b'
abbr -a gcot='git checkout --theirs'
abbr -a gd='git diff'
abbr -a gdn='git diff --name-only'
abbr -a gdt='git difftool'
abbr -a gl='git log'
abbr -a gm='git merge'
abbr -a gp='git push'
abbr -a gpbo='git push --set-upstream origin (git rev-parse --abbrev-ref HEAD)'
abbr -a gpod='git push origin --delete'
abbr -a grp='git rev-parse'
abbr -a grph='git rev-parse HEAD'
abbr -a gs='git status'
abbr -a gsmi='git submodule init'
abbr -a gsmu='git submodule update'
abbr -a gtl='git stash list'
abbr -a gu='git pull'
abbr -a gur='git pull --rebase'
abbr -a gpbo='git-push-branch-origin'
abbr -a gdtcmo='git-difftool-commit-minus-one'
abbr -a gtp='git-stash-pop'
abbr -a gta='git-stash-apply'
abbr -a gts='git-stash-show'
abbr -a gts='git-stash-show'
abbr -a gtd='git-stash-diff'

# hub
abbr -a hb='hub browse'
abbr -a hbc='hub browse -- commits'
