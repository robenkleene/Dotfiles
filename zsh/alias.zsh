# Basic
alias -- -='cd -'
alias ..='cd ..'

# Override

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

# Shortcut

# zsh
alias ei='zsh-edit-config'

# scripts
alias n='new-terminal-here'
alias o='new-finder-window-here'

# grep
alias -g G='| grep'

# ack
# alias a='ag'
alias a='rg'

# tig
alias ts='tig status +3'

# tmux
alias tmls='tmux ls'
alias tnd='tmux-name-directory'

# emacs
alias ec='emacsclient -t'
alias e='emacs-edit'
alias m='magit'

# ranger
alias r='ranger-cd'

# vim
# alias va='vim-pipe-grep' 
# alias vrs='vim-restore-session'
alias v='vim-edit' 
# alias vsr='vim-server-start -c "RestoreSession"'

# fzf
# alias f='fzf-file-vim'
# alias d='fzf-directory-cd'
# alias fcd='fzf-directory-cd'
# alias fh='fzf-history-cd'
# alias fx='fzf-project-xcode'
# alias fa='fzf-ack-vim' 
# alias fzc='fzf-directory-cd'
# alias fze='fzf-file-emacs'
# alias fzp='fzf-file-path'
# alias fzs='fzf-snippet'
# alias fzt='fzf-file-tig'
# alias fzb='fzf-bookmark-cd'
# alias fzd='fzf-documentation-vim'
# alias fzvse='fzf-file-vim-server-edit'
# alias fzvss='fzf-file-vim-server-start'
if [ "$(uname)" = "Darwin" ]; then
#   alias fzab='fzf-ack-bbedit'
#   alias fzam='fzf-ack-mate'
#   alias fzbb='fzf-file-bbedit'
#   alias fzm='fzf-file-mate'
#   alias fzo='fzf-file-open'
#   alias fzr='fzf-file-reveal'
#   alias fzx='fzf-file-xcode'
fi

# ssh
if [ "$(uname)" = "Darwin" ]; then
#   alias shs='ssh-start'
fi

# BBEdit
if [ "$(uname)" = "Darwin" ]; then
#   alias bbr='bbedit-pipe-grep'
fi

# git
# alias gvm='git-vim-modified'
alias gur='git pull --rebase'
alias gu='git pull'
alias gsmi='git submodule init'
alias gsmu='git submodule update'
alias gs='git status'
alias grc='git rebase --continue'
alias gpt='git push --tags'
alias gp='git push'
alias gf='git fetch'
alias gcom='git checkout -- .'
# alias gcd='git-cd-root'
alias gca='git commit --amend'
alias gbr='git branch --remotes'
# alias gbpr='git-prune-remote-origin'
# alias gprb='git-prune-remote-origin'
alias gaa='git add --all :/'

# hub
if [ "$(uname)" = "Darwin" ]; then
  alias hb='hub browse'
  alias hbc='hub browse -- commits'
fi
