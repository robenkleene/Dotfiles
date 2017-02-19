# ag
alias ag 'ag --path-to-ignore ~/.ignore'

# rg
alias rg 'rg --smart-case --line-number'

# mitmproxy
# Supposedly these can be set in a `~/.mitmproxy/config.yaml`, it wasn't
# working with:
# palette_transparent: true
# no_mouse: true
alias mitmproxy 'mitmproxy --no-mouse --palette-transparent'

# short

# alias a 'ag'
alias a 'rg'
alias af 'rg --files -g'
alias n 'new-terminal-here'
alias o 'new-finder-window-here'
alias t 'tmux' 
alias ts 'tig status +3'
alias ec 'emacsclient -t'
# Functions
alias r 'ranger-cd'
alias v 'vim-edit' 
alias e 'emacs-edit'
alias m 'magit'
alias V 'vim-restore-session'
alias f 'fzf-file-vim'
alias d 'fzf-directory-cd'
alias fcd 'fzf-directory-cd'
alias fh 'fzf-history-cd'
alias fx 'fzf-project-xcode'
alias va 'vim-pipe-grep' 
alias fa 'fzf-ack-vim' 
