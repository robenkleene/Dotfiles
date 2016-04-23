#!/usr/bin/env fish

set --erase fish_user_abbreviations

# nvm
abbr -a nud='nvm use default'

# Single Letters
abbr -a n='new-terminal-here'
abbr -a o='new-finder-window-here'
abbr -a r='ranger-cd'
abbr -a b='fzf-bookmark-cd'
abbr -a t='tmux'
abbr -a -='cd -'

# Emacs
abbr -a ec='emacsclient -t'

# Tig
abbr -a ts='tig status +3'

# vim
abbr -a vpg='vim-pipe-grep'
abbr -a vrs='vim-restore-session'

# fzf
abbr -a fs='fzf-snippet'
abbr -a fbc='fzf-bookmark-cd'
abbr -a fdc='fzf-directory-cd'
abbr -a ffm='fzf-file-mate'
abbr -a ffo='fzf-file-open'
abbr -a ffr='fzf-file-reveal'
abbr -a ffv='fzf-file-vim'
abbr -a flv='fzf-line-vim'
abbr -a fpx='fzf-project-xcode'
abbr -a fsc='fzf-snippet-copy'
abbr -a fsr='fzf-snippet-reveal'

# git
abbr -a gvm='git-vim-modified'
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
