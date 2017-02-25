function ack-lines() {
  rg --no-heading $@
}
function ack-lines-color() {
  ack-lines --color=always $@
}
function ack-lines-no-color() {
  ack-lines --color=never $@
}

export FZF_DEFAULT_COMMAND='rg --files -g ""'

# Directories

# history
function fzf-history-cd() {
  cd $(fasd -l | fzf)
}

function fzf-bookmark-cd() {
  # Bookmarks
  local RKBOOKMARKS=(~/Dotfiles/)
  # Documentation
  RKBOOKMARKS+=(~/Documentation/ ~/Documentation/development-references/)
  # Development
  RKBOOKMARKS+=(~/Development/ ~/Development/Scratch/ ~/Development/Projects/ ~/Development/Scripts/ ~/Development/Snippets/)
  cd $(printf '%s\n' $RKBOOKMARKS | fzf)
}

# Files

# emacs
function fzf-file-emacs() {
  emacs-edit $(fzf)
}

# # vim
function fzf-file-vim() {
  vim-edit $(fzf)
}
function fzf-file-vim-server-edit() {
  vim-server-edit $(fzf)
}
function fzf-file-vim-server-start() {
  vim-server-start $(result)
}

# tig
function fzf-file-tig() {
  tig $(fzf)
}

# tmux
function fzf-tmux-window() {
  if [ -z "$TMUX" ]; then
    return
  fi
  local window=$(tmux list-windows | awk 'BEGIN{FS=" "} {print $1 $2}' | fzf | awk 'BEGIN{FS=":"} {print $1}')
  tmux select-window -t ":$window"
} 

# mate
if [ "$(uname)" = "Darwin" ]; then
  function fzf-file-mate() {
    mate $(fzf)
  }
fi

# # bbedit
if [ "$(uname)" = "Darwin" ]; then
  function fzf-file-bbedit() {
    bbedit $(fzf)
  }
fi

# reveal
if [ "$(uname)" = "Darwin" ]; then
  function fzf-file-reveal() {
    open -R $(fzf)
  }
fi

# open
if [ "$(uname)" = "Darwin" ]; then
  function fzf-file-open() {
    open $(fzf)
  }
fi

# cd
function fzf-file-cd() {
  cd $(dirname $(fzf))
}
  
# path
function fzf-file-path() {
  fzf | tr -d '\n' | tee /dev/tty | safecopy
}

# Documentation
function fzf-documentation-vim() {
  cd ~/Documentation/
  local filename=$(find * -type f -not -path '*/\.*' | fzf)
  if [ -n $filename]; then
    cd -
  else
    vim-edit "$HOME/Documentation/$filename"
  fi
}

# Lines

# vim
function fzf-line-vim() {
  local line=$(ack-lines-no-color "[a-zA-Z0-9]+" . | fzf --ansi)
  echo $line | vim -c "GrepBuffer" - 
}

# Snippets

# copy
function fzf-snippet-copy() {
  cd ~/Development/Snippets/
  find * -type f | fzf | tr '\n' '\0' | xargs -0 cat | tee /dev/tty | safecopy
  cd -
}

# vim
function fzf-snippet-vim() {
  cd ~/Development/Snippets/
  vim-edit $(find * -type f | fzf)
  cd -
}

# Project

# Xcode
if [ "$(uname)" = "Darwin" ]; then
  function fzf-project-xcode() {
    find . -path '*.xcodeproj' -prune -o -name '*.xcworkspace' -o -name '*.xcodeproj' | grep -vE "\/Carthage\/" | fzf  --select-1 | tr '\n' '\0' | xargs -0 open
  }
fi
if [ "$(uname)" = "Darwin" ]; then
  function fzf-file-xcode() {
    local ack_search_xcode="$FZF_DEFAULT_COMMAND --glob \"*.swift\" --glob \"*.h\" --glob \"*.m\""
    eval $ack_search_xcode | fzf  --select-1 | tr '\n' '\0' | xargs -0 open -a "Xcode"
    # open -a "Xcode" "$(eval $ack_search_xcode | fzf  --select-1)
  }
fi

# ack
function fzf-ack-vim() {
  echo $@ | tr -d '\n' | safecopy -pboard find
  local setup_system_clipboard=""
  if [ "$(uname)" = "Darwin" ]; then
    setup_system_clipboard="| let @0=@*"
  fi
  echo $(ack-lines-color $@ | fzf --ansi) | vim-edit -c "GrepBuffer" -c "let @/='$argv[-1]' $setup_system_clipboard | set hlsearch" -
}
