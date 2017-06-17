# grep
# alias -g G='| grep'
# alias -g L='| less'
# alias -g A='| rg'
# alias -g C='| safecopy'
# alias -g V="| $VIM_COMMAND -"

# Basic
alias -- -='cd -'
alias ..='cd ..'

if [ ! "$(uname)" = "Darwin" ]; then
  alias ls='ls --color=auto'
else
  alias ls='gls --color=auto'
fi

alias p='safepaste'
alias c='safecopy'

# Override

# rg
alias rg='rg --smart-case --line-number'
# mitmproxy
# Supposedly these can be set in a `~/.mitmproxy/config.yaml`, it wasn't
# working with:
# palette_transparent: true
# no_mouse: true
alias mitmproxy='mitmproxy --no-mouse --palette-transparent'

# vimdiff
alias vimdiff="nvim -d"

# Shortcut

# zsh
alias oi='zsh-edit-config'

# scripts
alias n='terminal-new'
alias o='finder-new'

# tmux
alias tmnd='tmux-name-directory'
alias tma='tmux-attach'
alias tmsr='tmux-session-restore'
alias tmsq='tmux-session-save-quit'

# emacs
# alias m='magit'

# ranger
alias r='ranger-cd'

# vim
alias vff='fzf-vim-file'
alias vfg='fzf-vim-grep'
alias vg='vim-grep'
alias vgh='vim-git-hunks'
alias vgm='vim-git-modified'
alias vgms='vim-git-modified-splits'
alias vse='vim-server-edit'
alias vsr='vim-session-restore'
alias vsrd='vim-session-restore-default'
alias vsrl='vim-session-restore-local'
alias vsrs='vim-server-start -c "RestoreSession"'
alias vss='vim-server-start'

# emacs
if [[ "$(uname)" = "Darwin" ]]; then
  alias gemacs="open -a emacs"
fi

# fzf
alias fzp='fzf-file-path'
alias fzs='fzf-snippet-copy'
alias fzse='fzf-snippet-vim'
alias fzb='fzf-bookmark-cd'
alias fzd='fzf-documentation-less'
alias fzde='fzf-documentation-vim'
alias fzrd='fzf-recent-cd'
if [ "$(uname)" = "Darwin" ]; then
  alias ox='fzf-project-xcode'
  alias fzab='fzf-ack-bbedit'
  alias fzam='fzf-ack-mate'
  alias fzo='fzf-file-open'
  alias fzr='fzf-file-reveal'
  alias fzx='fzf-file-xcode'
fi

# doc & snp
alias snp='fzf-snippet-copy'
alias snpe='fzf-snippet-vim'
alias doce='fzf-documentation-vim'
alias docc='fzf-documentation-cat'

# git
alias gyb='git-yank-branch'
alias gyh='git-yank-hash'
alias gyr='git-yank-remote-url'
alias gcd='git-cd-root'
alias dtv='dtg | vg'
