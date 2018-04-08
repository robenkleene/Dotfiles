# export FZF_DEFAULT_COMMAND='rg --files -g "" --hidden'
# Start including hidden files because these files often need to be edited, like `.gitignore`
export FZF_DEFAULT_COMMAND='fd --type f --hidden'

# fzf
# Make `fzf` bindings available, since this is being manually imported here
# `fzf` should be installed at `~/.fzf/`, using the command 
# `~/.fzf/install --bin`, which avoids installing the completions automatically
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
# Including hidden directories to be consistent with `fd` is there a reason not to?
export FZF_ALT_C_COMMAND='fd --type d --hidden'

# source ~/.fzf/shell/completion.zsh
# source ~/.fzf/shell/key-bindings.zsh
# Put back default history search
bindkey '^R' history-incremental-search-backward
# bindkey '^[r' fzf-history-widget

# Library

__fzf-cmd() {
  local cmd="$1"
  local term="$2"
  if [[ -n "$term" ]]; then
    query="--query=\"$term\" "
  fi
  setopt localoptions pipefail 2> /dev/null
  eval "$cmd" | FZF_DEFAULT_OPTS="$query--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS" fzf +m
  local ret=$?
  echo
  return $ret
}

__fzf-buffer-match() {
  local cmd="$1"
  local MATCH
  LBUFFER=${LBUFFER%%(#m)[_\-a-zA-Z0-9]#}
  local result=$(__fzf-cmd $cmd $MATCH)
  local ret=$?
  if [[ -n "$result" ]]; then
    LBUFFER+="${(q)result} "
  else
    LBUFFER+=$MATCH
  fi
  zle redisplay
  # typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}

__zsh-add-history() {
  print -sr -- ${1%%$'\n'}
  # Disabling instantaneous refresh for now, because I'm concerned about the
  # performance impact and corrupting history, hit enter to refresh history
  # fc -AI
  # fc -R
  # For some reason reading incrementally messes up the history stack, this
  # whole approach for history refersh is probably wrong.
  # fc -RI
}

__fzf-reset-finish() {
  zle reset-prompt
  # typeset -f zle-line-init >/dev/null && zle zle-line-init
}

# Widgets

_fzf-cd-widget() {
  local cmd=$FZF_ALT_C_COMMAND

  if [[ -n "$LBUFFER" ]]; then
    __fzf-buffer-match "$cmd"
    local ret=$?
    return $ret
  fi

  local dir=$(__fzf-cmd "$cmd") 
  if [[ ! -d "$dir" ]]; then
    zle redisplay
    return 1
  fi
  cd "$dir"

  local ret=$?
  __zsh-add-history "cd ${(q)dir}"
  __fzf-reset-finish
  return $ret
}
zle -N _fzf-cd-widget
bindkey '\ec' _fzf-cd-widget

_fzf-editor-widget() {
  local cmd=$FZF_CTRL_T_COMMAND

  if [[ -n "$LBUFFER" ]]; then
    __fzf-buffer-match "$cmd"
    local ret=$?
    return $ret
  fi

  local file=$(__fzf-cmd "$cmd") 
  if [[ ! -f "$file" ]]; then
    zle redisplay
    return 1
  fi
  eval $EDITOR ${(q)file}

  local ret=$?
  __zsh-add-history "$EDITOR ${(q)file}"
  __fzf-reset-finish
  return $ret
}
zle -N _fzf-editor-widget
bindkey '\ee' _fzf-editor-widget

_fzf-z-widget() {
  local cmd="fasd -Rdl"

  if [[ -n "$LBUFFER" ]]; then
    __fzf-buffer-match "$cmd"
    local ret=$?
    return $ret
  fi

  local dir=$(__fzf-cmd "$cmd") 
  if [[ ! -d "$dir" ]]; then
    zle redisplay
    return 1
  fi
  cd "$dir"

  local ret=$?
  __zsh-add-history "cd ${(q)dir}"
  __fzf-reset-finish
  return $ret
}
zle -N _fzf-z-widget
bindkey '\ez' _fzf-z-widget

_fzf-zvim-widget() {
  local cmd="fasd -Rfl"

  if [[ -n "$LBUFFER" ]]; then
    __fzf-buffer-match "$cmd"
    local ret=$?
    return $ret
  fi

  local file=$(__fzf-cmd "$cmd") 
  if [[ ! -f "$file" ]]; then
    zle redisplay
    return 1
  fi
  eval $EDITOR ${(q)file}

  local ret=$?
  __zsh-add-history "$EDITOR ${(q)file}"
  __fzf-reset-finish
  return $ret
}
zle -N _fzf-zvim-widget
bindkey '\er' _fzf-zvim-widget


# Special

# Tags uses a special `fzf` command
_fzf-tags-widget() {
  if [[ -n "$LBUFFER" ]]; then
    return
  fi
  local cmd="~/Development/Dotfiles/vim/plugged/fzf.vim/bin/tags.pl tags"
  setopt localoptions pipefail 2> /dev/null
  local result="$(eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --nth 1..2 --tiebreak=begin $FZF_DEFAULT_OPTS" fzf +m)"
  if [[ -z "$result" ]]; then
    zle redisplay
    return 0
  fi
  echo $result | $VIM_COMMAND -c "TagBuffer" -
  local ret=$?
  zle reset-prompt
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}
zle -N _fzf-tags-widget
bindkey '\ei' _fzf-tags-widget

# Commands does extra work with the `commands` and `functions` variables
__fcmd() {
  local query=""
  if [[ -n "$1" ]]; then
    query="--query=\"$1\" "
  fi
  local cmds=( ${(k)functions[@]} ${(k)commands[@]} )
  # There's a shell command called `g[` that `eval` has trouble parsing
  cmds=("${(@)cmds:#g\[}")
  local cmd="print -l \\"$cmds\\" | grep -E -v \"^(_|VCS)\""
  setopt localoptions pipefail 2> /dev/null
  eval "$cmd" | FZF_DEFAULT_OPTS="$query--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS" fzf | while read item; do
    echo -n "${(q)item} "
  done
  local ret=$?
  echo
  return $ret
}
_fzf-command-widget() {
  local MATCH
  LBUFFER=${LBUFFER%%(#m)[_\-a-zA-Z0-9]#}
  LBUFFER+="$(__fcmd $MATCH)"
  local ret=$?
  zle redisplay
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}
zle     -N   _fzf-command-widget
bindkey '^@' _fzf-command-widget

_robenkleene_fzf_inline_result() {
  local list_cmd=${1-$FZF_DEFAULT_COMMAND} 
  setopt localoptions pipefail 2> /dev/null
  local result="$(eval "$list_cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS" fzf +m)"
  local ret=$?
  echo $result
  return $ret
}

# Safari
fzf-safari-history-open() {
  local result=$(safari-history-dump \
    | FZF_DEFAULT_OPTS="-m --reverse --prompt \"Safari History> \" \
    --height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS" fzf +m \
    | cut -f2)
  if [[ -n $result ]]; then
    open "$result"
  fi
}

# Documentation
fzf-documentation-editor() {
  cd ~/Documentation/
  local result=$(_robenkleene_fzf_inline_result)
  if [[ -n "$result" ]]; then
    local parameter=$(printf '%q' "$PWD/$result")
    local final_cmd="$EDITOR $parameter"
    eval $final_cmd
    if [ $? -eq 0 ]; then
      # Add to history
      print -sr $final_cmd
    fi
  else
    cd -
  fi
}

# Snippets
fzf-snippet-copy() {
  cd ~/Development/Snippets/
  local result=$(_robenkleene_fzf_inline_result)
  if [[ -n $result ]]; then
    echo $result | tr '\n' '\0' | xargs -0 cat | tee /dev/tty | safecopy
  fi
  cd -
}
fzf-snippet-editor() {
  cd ~/Development/Snippets/
  local result=$(_robenkleene_fzf_inline_result)
  if [[ -n $result ]]; then
    local parameter=$(printf '%q' "$PWD/$result")
    local final_cmd="$EDITOR $parameter"
    eval $final_cmd
    if [ $? -eq 0 ]; then
      # Add to history
      print -sr $final_cmd
    fi
  else
    cd -
  fi
}

# Xcode
if [ "$(uname)" = "Darwin" ]; then
  fzf-project-xcode() {
    setopt localoptions pipefail 2> /dev/null
    find . -path '*.xcodeproj' -prune -o -name '*.xcworkspace' -o -name '*.xcodeproj' \
      | grep -vE "\/Carthage\/" \
      | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --select-1 $FZF_DEFAULT_OPTS" fzf +m \
      | tr '\n' '\0' \
      | xargs -0 open
  }
fi
if [ "$(uname)" = "Darwin" ]; then
  fzf-file-xcode() {
    local ack_search_xcode="$FZF_DEFAULT_COMMAND --glob \"*.swift\" --glob \"*.h\" --glob \"*.m\""
    eval $ack_search_xcode \
      | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS" fzf +m \
      | tr '\n' '\0' \
      | xargs -0 open -a "Xcode"
  }
fi

# ack
fzf-vim-grep() {
  FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --ansi $FZF_DEFAULT_OPTS" fzf +m | local result=`cat`
  echo $result | $VIM_COMMAND -c "GrepBuffer" -
}
fzf-vim-file() {
  FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --ansi $FZF_DEFAULT_OPTS" fzf +m | local result=`cat`
  $VIM_COMMAND $result
}

fzf-tmux-vim-file() {
  tmux-paths -0 \
    | xargs -0 rg --files -g "" \
    | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --select-1 $FZF_DEFAULT_OPTS" fzf +m \
    | tr '\n' '\0' \
    | xargs -0 $VIM_COMMAND
}
