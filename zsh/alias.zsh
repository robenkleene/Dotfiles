# ag
alias ag='ag --path-to-ignore ~/.ignore'

# rg
alias rg='rg --smart-case --line-number'

# mitmproxy
# Supposedly these can be set in a `~/.mitmproxy/config.yaml`, it wasn't
# working with:
# palette_transparent: true
# no_mouse: true
alias mitmproxy='mitmproxy --no-mouse --palette-transparent'

# short

# alias a='ag'
alias a='rg'
alias n='new-terminal-here'
alias o='new-finder-window-here'
alias t='tmux' 
alias ts='tig status +3'
alias ec='emacsclient -t'
# # Functions
alias r='ranger-cd'
# alias v='vim-edit' 
# alias e='emacs-edit'
# alias m='magit'
# alias V='vim-restore-session'
# alias f='fzf-file-vim'
# alias d='fzf-directory-cd'
# alias fcd='fzf-directory-cd'
# alias fh='fzf-history-cd'
# alias fx='fzf-project-xcode'
# alias va='vim-pipe-grep' 
# alias fa='fzf-ack-vim' 

# Basic
alias -- -='cd -'

# ssh
# if not test (uname) = Darwin
#   alias shs='ssh-start'
# end

# BBEdit
# if test (uname) = Darwin
#   alias bbr='bbedit-pipe-grep'
# end

# fzf
# alias fza='fzf-ack-vim'
# alias fzc='fzf-directory-cd'
# alias fze='fzf-file-emacs'
# alias fzp='fzf-file-path'
# alias fzs='fzf-snippet'
# alias fzt='fzf-file-tig'
# alias fzb='fzf-bookmark-cd'
# alias fzd='fzf-documentation-vim'
# alias fzvse='fzf-file-vim-server-edit'
# alias fzvss='fzf-file-vim-server-start'
# if test (uname) = Darwin
#   alias fzab='fzf-ack-bbedit'
#   alias fzam='fzf-ack-mate'
#   alias fzbb='fzf-file-bbedit'
#   alias fzm='fzf-file-mate'
#   alias fzo='fzf-file-open'
#   alias fzr='fzf-file-reveal'
#   alias fzx='fzf-file-xcode'
# end

# tig
alias tst='tig stash'

# tmux
# alias ta='tmux-attach'
# alias tmd='tmux-documentation'
alias tmls='tmux ls'
# alias tnd='tmux-name-directory'
alias tmsw='tmux swap-window -t'

# vim
# alias vss='vim-server-start'
# alias vse='vim-server-edit'
# alias VSS='vim-server-start -c "RestoreSession"'
# # This command doesn't work yet, try `fzf-ack-vim` instead
# # alias vgc='vim-pipe-grep-clipboard'
# alias vc='vim-clipboard'
# alias vrs='vim-restore-session'

# git
alias ga='git add'
alias gaa='git add --all :/'
alias gb='git branch'
alias gbd='git branch --delete'
# alias gbpr='git-prune-remote-origin'
# alias gprb='git-prune-remote-origin'
alias gbr='git branch --remotes'
alias gc='git commit'
alias gca='git commit --amend'
alias gcd='git-cd-root'
alias gcam='git commit --amend -m'
# alias gch='git-copy-commit-hash'
alias gcl='git clone'
alias gcm='git commit -m'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout -- .'
alias gd='git diff'
alias gdt='git difftool'
alias gf='git fetch'
alias gl='git log'
alias gm='git merge'
alias gp='git push'
# alias gpbo='git-push-branch-origin'
# alias gpb='git-push-branch-origin'
alias gpod='git push origin --delete'
alias gpt='git push --tags'
alias gr='git rebase'
alias grc='git rebase --continue'
alias gs='git status'
alias gsm='git submodule'
alias gsmi='git submodule init'
alias gsmu='git submodule update'
# alias gsta='git-stash-apply'
# alias gstd='git-stash-diff'
alias gstl='git stash list'
# alias gstp='git-stash-pop'
alias gsts='git stash save'
# alias gstsh='git-stash-show'
alias gt='git tag'
alias gu='git pull'
alias gur='git pull --rebase'
alias gvm='git-vim-modified'

# hub
# if test (uname) = Darwin
#   alias hb='hub browse'
#   alias hbc='hub browse -- commits'
# end
