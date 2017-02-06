#!/usr/bin/env fish

set --erase fish_user_abbreviations

# Destructive, don't abbreviate
# git-push-force
# git stash
# git-reset

# Basic
abbr -a -- - 'cd -'

# ssh
if not test (uname) = Darwin
  abbr -a shs='ssh-start'
end

# nvm
abbr -a nud='nvm use default'

# vim
abbr -a vpg='vim-pipe-grep'
abbr -a vc='vim-clipboard'
abbr -a vrs='vim-restore-session'

# BBEdit
if test (uname) = Darwin
  abbr -a bbr='bbedit-pipe-grep'
end

# fish
abbr -a fec='fish-edit-config'
abbr -a fea='fish-edit-abbreviations'
abbr -a fsa='fish-sync-abbreviations'
abbr -a fsh='fish-sync-history'
abbr -a fhm='history merge'

# fzf
abbr -a fza='fzf-ack-vim'
abbr -a fzc='fzf-directory-cd'
abbr -a fze='fzf-file-emacs'
abbr -a fzp='fzf-file-path'
abbr -a fzs='fzf-snippet'
abbr -a fzt='fzf-file-tig'
if test (uname) = Darwin
  abbr -a fzab='fzf-ack-bbedit'
  abbr -a fzam='fzf-ack-mate'
  abbr -a fzb='fzf-file-bbedit'
  abbr -a fzm='fzf-file-mate'
  abbr -a fzo='fzf-file-open'
  abbr -a fzr='fzf-file-reveal'
  abbr -a fzx='fzf-file-xcode'
end

# carthage
abbr -a csmu='carthage-submodule-update'
abbr -a csmb='carthage-submodule-bootstrap'

# tig
abbr -a tst='tig stash'

# cd
abbr -a ccp='cd-copy-path'

# tmux
abbr -a ta='tmux-attach'
abbr -a tmd='tmux-documentation'
abbr -a tmls='tmux ls'
abbr -a tmnd='tmux-name-directory'
abbr -a tnd='tmux-name-directory'

# git
abbr -a ga='git add'
abbr -a gaa='git add --all :/'
abbr -a gb='git branch'
abbr -a gbd='git branch --delete'
abbr -a gbpr='git-prune-remote-origin'
abbr -a gprb='git-prune-remote-origin'
abbr -a gbr='git branch --remotes'
abbr -a gc='git commit'
abbr -a gca='git commit --amend'
abbr -a gcd='git-cd-root'
abbr -a gcam='git commit --amend -m'
abbr -a gch='git-copy-commit-hash'
abbr -a gcl='git clone'
abbr -a gcm='git commit -m'
abbr -a gco='git checkout'
abbr -a gcob='git checkout -b'
abbr -a gcot='git checkout --theirs'
abbr -a gcom='git checkout -- .'
abbr -a gd='git diff'
abbr -a gdn='git diff --name-only'
abbr -a gdt='git difftool'
abbr -a gdtcmo='git-difftool-commit-minus-one'
abbr -a gdw='git-diff-words'
abbr -a gf='git fetch'
abbr -a gh='git-commit-hash'
abbr -a gl='git log'
abbr -a gm='git merge'
abbr -a gp='git push'
abbr -a gpbo='git-push-branch-origin'
abbr -a gpb='git-push-branch-origin'
abbr -a gpod='git push origin --delete'
abbr -a gpt='git push --tags'
abbr -a gr='git rebase'
abbr -a grc='git rebase --continue'
abbr -a grp='git rev-parse'
abbr -a grph='git rev-parse HEAD'
abbr -a gs='git status'
abbr -a gsm='git submodule'
abbr -a gsmcl='git-submodule-clean-checkout'
abbr -a gsmi='git submodule init'
abbr -a gsmuir='git-submodule-update-init-recursive'
abbr -a gsmu='git submodule update'
abbr -a gsmr='git-submodule-reset'
abbr -a gsta='git-stash-apply'
abbr -a gstd='git-stash-diff'
abbr -a gstl='git stash list'
abbr -a gstk='git stash --keep-index'
abbr -a gstp='git-stash-pop'
abbr -a gsts='git stash save'
abbr -a gstsh='git-stash-show'
abbr -a gt='git tag'
abbr -a gtd='git tag --delete'
abbr -a gu='git pull'
abbr -a gur='git pull --rebase'
abbr -a gvm='git-vim-modified'

# hub
if test (uname) = Darwin
  abbr -a hb='hub browse'
  abbr -a hbc='hub browse -- commits'
end
