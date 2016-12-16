#!/usr/bin/env fish

set --erase fish_user_abbreviations

# nvm
abbr -a nud='nvm use default'

# vim
abbr -a vpg='vim-pipe-grep'
abbr -a vc='vim-clipboard'
abbr -a vrs='vim-restore-session'

# BBEdit
abbr -a bbr='bbedit-pipe-grep'

# fish
abbr -a fec='fish-edit-config'
abbr -a fsa='fish-sync-abbreviations'

# fzf
abbr -a fza='fzf-ack-vim'
abbr -a fzab='fzf-ack-bbedit'
abbr -a fzam='fzf-ack-mate'
abbr -a fzb='fzf-file-bbedit'
abbr -a fzc='fzf-directory-cd'
abbr -a fze='fzf-file-emacs'
abbr -a fzm='fzf-file-mate'
abbr -a fzo='fzf-file-open'
abbr -a fzp='fzf-file-path'
abbr -a fzr='fzf-file-reveal'
abbr -a fzs='fzf-snippet'
abbr -a fzx='fzf-file-xcode'

# carthage
abbr -a csmu='carthage-submodule-update'
abbr -a csmb='carthage-submodule-bootstrap'

# cd
abbr -a ccp='cd-copy-path'

# tmux
abbr -a tma='tmux attach -t'
abbr -a ta='tmux attach -t'
abbr -a tmls='tmux ls'
abbr -a tmnd='tmux-name-directory'
abbr -a tmd='tmux-documentation'

# git
abbr -a g='gitup'
abbr -a ga='git add'
abbr -a gaa='git add --all :/'
abbr -a gb='git branch'
abbr -a gbd='git branch -d'
abbr -a gbpr='git-prune-remote-origin'
abbr -a gprb='git-prune-remote-origin'
abbr -a gbr='git branch -r'
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
abbr -a gpod='git push origin --delete'
abbr -a gpt='git push --tags'
abbr -a gr='git rebase'
abbr -a grp='git rev-parse'
abbr -a grph='git rev-parse HEAD'
abbr -a gs='git status'
abbr -a gsm='git submodule'
abbr -a gsmcl='git-submodule-clean-checkout'
abbr -a gsmi='git submodule init'
abbr -a gsmuir='git-submodule-update-init-recursive'
abbr -a gsmu='git submodule update'
abbr -a gsmr='git-submodule-reset'
abbr -a gst='git stash list'
abbr -a gsta='git-stash-apply'
abbr -a gstd='git-stash-diff'
abbr -a gstl='git stash list'
abbr -a gstk='git stash --keep-index'
abbr -a gstp='git-stash-pop'
abbr -a gsts='git-stash-show'
abbr -a gt='git tag'
abbr -a gtd='git tag --delete'
abbr -a gu='git pull'
abbr -a gur='git pull --rebase'
abbr -a gvm='git-vim-modified'

# hub
abbr -a hb='hub browse'
abbr -a hbc='hub browse -- commits'
