#!/usr/bin/env fish

set --erase fish_user_abbreviations

# nvm
abbr -a nud='nvm use default'

# vim
abbr -a vpg='vim-pipe-grep'
abbr -a vrs='vim-restore-session'

# BBEdit
abbr -a bbr='bbresults'

# fish
abbr -a fec='fish-edit-config'

# fzf
# Defaults
abbr -a snp='fzf-snippet'
abbr -a fs='fzf-snippet'
abbr -a fx='fzf-project-xcode'
# Others
abbr -a fbc='fzf-bookmark-cd'
abbr -a fdc='fzf-directory-cd'
abbr -a ffc='fzf-file-cd'
abbr -a ffm='fzf-file-mate'
abbr -a ffo='fzf-file-open'
abbr -a ffr='fzf-file-reveal'
abbr -a ffp='fzf-file-path'
abbr -a ffv='fzf-file-vim'
abbr -a flv='fzf-line-vim'
abbr -a fpx='fzf-project-xcode'
abbr -a frc='fzf-result-cd'
abbr -a frv='fzf-result-vim'
abbr -a fsc='fzf-snippet-copy'
abbr -a fsr='fzf-snippet-reveal'

# git
abbr -a gvm='git-vim-modified'
abbr -a ga='git add'
abbr -a gdw='git-diff-words'
abbr -a gaa='git add --all :/'
abbr -a gb='git branch'
abbr -a gbd='git branch -d'
abbr -a gc='git commit'
abbr -a gca='git commit --amend'
abbr -a gcam='git commit --amend -m'
abbr -a gcl='git-clean-checkout'
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
abbr -a gr='git rebase'
abbr -a grp='git rev-parse'
abbr -a grph='git rev-parse HEAD'
abbr -a gs='git status'
abbr -a gsm='git submodule'
abbr -a gsmi='git submodule init'
abbr -a gsmu='git submodule update'
abbr -a gsmcl='git-submodule-clean-checkout'
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
