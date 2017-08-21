# grep
alias -g G='| grep'
alias -g C='| column'
alias -g L='| less'
alias -g A='| rg'
alias -g Y='| safecopy'
alias -g Y1='| safecopy1'
alias -g B='| bbresults --pattern grep'
# Disable these, there's something very strange about how global aliases call
# interactive commads. Starting `vim` results it in having to start twice,
# which is very slow.
# alias -g V="| $VIM_COMMAND -"
# alias -g Q='| vim-grep'
alias -g V="$VIM_COMMAND -"
alias -g Q='vim-grep'
alias -g F='fzf-vim-grep'
alias -g FF='fzf-vim-file'

# Basic
alias -- -='cd -'
alias ..='cd ..'

if [ ! "$(uname)" = "Darwin" ]; then
  alias ls='ls --color=auto'
else
  alias ls='gls --color=auto'
fi

alias p='safepaste'
alias y='safecopy'
alias safecopy1='tr -d '\''\n'\'' | tee /dev/tty | safecopy'

# Override

# rg
alias rg="rg --smart-case --line-number --colors 'match:fg:black' --colors 'match:bg:cyan' --colors 'path:fg:cyan' --colors 'line:fg:white'"
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
alias dh='dirs -v'

# scripts
alias n='terminal-new'
alias o='finder-new'

# tmux
alias tmnd='tmux-name-directory'
alias tma='tmux-attach'
alias tmsr='tmux-session-restore'
alias tmsq='tmux-session-save-quit'
alias tmp='tmux-paths'
alias tmc='tmux-paths-run'
alias atm='tmux-paths-rg'
alias tme='fzf-tmux-vim-file'
alias tmgs='tmux-git-status'

# emacs
alias m='magit'
alias e="$EMACS_COMMAND"

# ranger
alias r='ranger-cd'

# vim
alias vgh='vim-git-hunks'
alias vdg='vim-diff-grep'
alias vgm='vim-git-modified'
alias vgc='vim-git-conflicts'
alias vse='vim-server-edit'
alias vsr='vim-session-restore'
alias var='vim-session-restore-auto'
# alias vss='vim-server-start'

# emacs
if [[ "$(uname)" = "Darwin" ]]; then
  alias gemacs="open -a emacs"
fi

# Xcode
if [ "$(uname)" = "Darwin" ]; then
  alias xcb='xcodebuild-debug'
  alias ox='fzf-project-xcode'
fi

# doc & snp
alias snp='fzf-snippet-copy'
alias snpe='fzf-snippet-editor'
alias doce='fzf-documentation-editor'
alias docc='fzf-documentation-cat'

# git
alias gyb='git-yank-branch'
alias gyh='git-yank-hash'
alias gyr='git-yank-remote-url'
alias gcd='git-cd-root'
alias dtv='diff-to-grep | vg'
