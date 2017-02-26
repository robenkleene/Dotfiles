export FZF_DEFAULT_COMMAND='rg --files -g ""'

# Private

function _robenkleene_ack_lines() {
  rg --no-heading $@
}
function _robenkleene_ack_lines_color() {
  _robenkleene_ack_lines --color=always $@
}
function _robenkleene_ack_lines_no_color() {
  _robenkleene_ack_lines --color=never $@
}

function _robenkleene_fzf_inline() {
  local result_cmd=$1
  local list_cmd=${2-$FZF_DEFAULT_COMMAND} 
  setopt localoptions pipefail 2> /dev/null
  local result="$(eval "$list_cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS" $(__fzfcmd) +m)"
  if [[ -z "$result" ]]; then
    return 0
  fi
  local final_cmd="$result_cmd \"$result\""
  eval $final_cmd
  local ret=$?
  if [ $? -eq 0 ]; then
    # Add to history
    print -s $final_cmd
  fi
  return $ret
}

function _robenkleene_fzf_inline_result() {
  local list_cmd=${1-$FZF_DEFAULT_COMMAND} 
  setopt localoptions pipefail 2> /dev/null
  local result="$(eval "$list_cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS" $(__fzfcmd) +m)"
  local ret=$?
  echo $result
  return $ret
}

# Directories

# History
function fzf-recent-cd() {
  _robenkleene_fzf_inline cd "fasd -ld"
}

function fzf-bookmark-cd() {
  # Bookmarks
  local bookmarks=(~/Development/Dotfiles/)
  # Documentation
  bookmarks+=(~/Documentation/ ~/Documentation/development-references/)
  # Development
  bookmarks+=(~/Development/ ~/Development/Scratch/ ~/Development/Projects/ ~/Development/Scripts/ ~/Development/Snippets/)
  _robenkleene_fzf_inline cd "printf '%s\n' $bookmarks"
}

# Files

# vim
function fzf-file-vim() {
  _robenkleene_fzf_inline vim-edit
}

# reveal
if [ "$(uname)" = "Darwin" ]; then
  function fzf-file-reveal() {
    _robenkleene_fzf_inline "open -R"
  }
fi

# open
if [ "$(uname)" = "Darwin" ]; then
  function fzf-file-open() {
    _robenkleene_fzf_inline open
  }
fi

# path
function fzf-file-path() {
  local result=$(_robenkleene_fzf_inline_result)
  echo $result | tr -d '\n' | tee /dev/tty | safecopy
}

# Documentation
function fzf-documentation-vim() {
  cd ~/Documentation/
  local result=$(_robenkleene_fzf_inline_result)
  if [[ -n $result ]]; then
    vim-edit "$result"
  else
    cd -
  fi
}

# Lines

# vim
function fzf-line-vim() {
  local line=$(_robenkleene_ack_lines_no_color "[a-zA-Z0-9]+" . | fzf --ansi)
  echo $line | vim -c "GrepBuffer" - 
}

# Snippets

# copy
function fzf-snippet-copy() {
  cd ~/Development/Snippets/
  local result=$(_robenkleene_fzf_inline_result)
  if [[ -n $result ]]; then
    echo $result | tr '\n' '\0' | xargs -0 cat | tee /dev/tty | safecopy
  fi
  cd -
}

# vim
function fzf-snippet-vim() {
  cd ~/Development/Snippets/
  local result=$(_robenkleene_fzf_inline_result)
  if [[ -n $result ]]; then
    vim-edit $result
  else
    cd -
  fi
}

# Project

# Xcode
if [ "$(uname)" = "Darwin" ]; then
  function fzf-project-xcode() {
    setopt localoptions pipefail 2> /dev/null
    find . -path '*.xcodeproj' -prune -o -name '*.xcworkspace' -o -name '*.xcodeproj' \
      | grep -vE "\/Carthage\/" \
      | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --select-1 --reverse $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS" $(__fzfcmd) +m \
      | tr '\n' '\0' \
      | xargs -0 open
  }
fi

if [ "$(uname)" = "Darwin" ]; then
  function fzf-file-xcode() {
    local ack_search_xcode="$FZF_DEFAULT_COMMAND --glob \"*.swift\" --glob \"*.h\" --glob \"*.m\""
    eval $ack_search_xcode \
      | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS" $(__fzfcmd) +m \
      | tr '\n' '\0' \
      | xargs -0 open -a "Xcode"
  }
fi

# ack
function fzf-ack-vim() {
  echo $@ | tr -d '\n' | safecopy -pboard find
  local setup_system_clipboard=""
  if [ "$(uname)" = "Darwin" ]; then
    setup_system_clipboard="| let @0=@*"
  fi
  echo $(_robenkleene_ack_lines_color $@ | fzf --ansi) | vim-edit -c "GrepBuffer" -c "let @/='$argv[-1]' $setup_system_clipboard | set hlsearch" -
}
