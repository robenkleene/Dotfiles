# grep
alias -g G='| grep'
alias -g C='| column'
alias -g L='| less'
alias -g A='| rg --no-line-number --no-filename'
alias -g Y='| safecopy'
alias -g Y1='| safecopy1'
alias -g B='| bbresults --pattern grep --new-window'
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
# Adding `--line-number` interferes with piping to `rg`, but without it piping
# to `vim` will also not have line numbers, so it needs to be turned on here.
# To work around this, when piping to it use the `A` global alias.
alias rg="rg --with-filename --smart-case --line-number --colors 'match:fg:black' --colors 'match:bg:cyan' --colors 'path:fg:cyan' --colors 'line:fg:white'"
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
alias ol="$EDITOR settings.sh"
alias sl="source settings.sh"
alias ob="$EDITOR build.log"
alias ot="$EDITOR test.log"
alias dh='dirs -v'

# scripts
alias n='terminal-new'
alias o='finder-new'

# tmux
alias tmnd='tmux-name-directory'
alias tmsa='tmux-attach'
alias tmsr='tmux-session-restore'
alias tmsq='tmux-session-save-quit'
alias tmp='tmux-paths'
alias tmc='tmux-paths-run'
alias tma='tmux-paths-rg'
alias tme='fzf-tmux-vim-file'
alias tmgs='tmux-git-status'

# emacs
alias m='magit'
alias e="$EMACS_COMMAND"

# ranger
alias r='ranger-cd'

# vim
alias vtd='vim-todo'
alias vgd='vim-git-diff'
alias vdg='vim-diff-grep'
alias vgm='vim-git-modified'
alias vgc='vim-git-conflicts'
alias vse='vim-server-edit'
alias vsr='vim-session-restore'
alias vsra='vim-session-restore-auto'
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

# cd
alias cdtd='cd-todo'

# tags
alias i='fzf-tags-vim'

# doc & snp
alias snp='fzf-snippet-copy'
alias snpe='fzf-snippet-editor'
alias doce='fzf-documentation-editor'
alias docc='fzf-documentation-cat'

# git
alias gbp='git-branch-print'
alias gh='git-hash-print'
alias ghp='git-hash-print'
alias grt='git-remote-print'
alias grtp='git-remote-print'
alias gcd='git-cd-root'
alias dtv='diff-to-grep | vg'
