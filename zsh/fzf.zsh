# export FZF_DEFAULT_COMMAND='rg --files -g "" --hidden'
# Start including hidden files because these files often need to be edited, like `.gitignore`
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git --exclude .DS_Store'

# fzf
# Make `fzf` bindings available, since this is being manually imported here
# `fzf` should be installed at `~/.fzf/`, using the command 
# `~/.fzf/install --bin`, which avoids installing the completions automatically
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
# Including hidden directories to be consistent with `fd` is there a reason not to?
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'

# source ~/.fzf/shell/completion.zsh
# source ~/.fzf/shell/key-bindings.zsh
# Put back default history search
bindkey '^R' history-incremental-search-backward
# bindkey '^[r' fzf-history-widget

# Library

__fzf_cmd() {
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

__fzf_buffer_match() {
  local cmd="$1"
  local MATCH
  LBUFFER=${LBUFFER%%(#m)[_\-a-zA-Z0-9]#}
  local result=$(__fzf_cmd $cmd $MATCH)
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

__zsh_add_history() {
  print -sr -- ${1%%$'\n'}
  # Disabling instantaneous refresh for now, because I'm concerned about the
  # performance impact and corrupting history, hit enter to refresh history
  # fc -AI
  # fc -R
  # For some reason reading incrementally messes up the history stack, this
  # whole approach for history refersh is probably wrong.
  # fc -RI
}

__fzf_reset_finish() {
  zle reset-prompt
  # typeset -f zle-line-init >/dev/null && zle zle-line-init
}

# Widgets

_fzf_cd_widget() {
  local cmd=$FZF_ALT_C_COMMAND

  if [[ -n "$LBUFFER" ]]; then
    local dir="${LBUFFER##* }"
    if [[ -d "$dir" ]]; then
      cmd="cd $dir && $cmd && cd - >/dev/null"
    fi
    __fzf_buffer_match "$cmd"
    local ret=$?
    return $ret
  fi

  local dir=$(__fzf_cmd "$cmd") 
  if [[ ! -d "$dir" ]]; then
    zle redisplay
    return 1
  fi
  cd "$dir"

  local ret=$?
  __zsh_add_history "cd ${(q)dir}"
  __fzf_reset_finish
  return $ret
}
zle -N _fzf_cd_widget
bindkey '\ec' _fzf_cd_widget

_fzf_editor_widget() {
  local cmd=$FZF_CTRL_T_COMMAND

  if [[ -n "$LBUFFER" ]]; then
    local dir="${LBUFFER##* }"
    if [[ -d "$dir" ]]; then
      cmd="cd $dir && $cmd && cd - >/dev/null"
    fi
    __fzf_buffer_match "$cmd"
    local ret=$?
    return $ret
  fi

  local file=$(__fzf_cmd "$cmd") 
  if [[ ! -f "$file" ]]; then
    zle redisplay
    return 1
  fi
  # `vim` spits "Warning: Input is not from a terminal" without the `<
  # /dev/tty`
  eval $EDITOR ${(q)file} < /dev/tty

  local ret=$?
  __zsh_add_history "$EDITOR ${(q)file}"
  __fzf_reset_finish
  return $ret
}
zle -N _fzf_editor_widget
bindkey '\ee' _fzf_editor_widget

_fzf_z_widget() {
  local cmd="fasd -Rdl"

  if [[ -n "$LBUFFER" ]]; then
    __fzf_buffer_match "$cmd"
    local ret=$?
    return $ret
  fi

  local dir=$(__fzf_cmd "$cmd") 
  if [[ ! -d "$dir" ]]; then
    zle redisplay
    return 1
  fi
  cd "$dir"

  local ret=$?
  __zsh_add_history "cd ${(q)dir}"
  __fzf_reset_finish
  return $ret
}
zle -N _fzf_z_widget
bindkey '\ez' _fzf_z_widget
# Work around what's probably a iTerm bug where if the first key press after a
  # new window is created is calling a widget, sometimes the character is
  # entered at the prompted instead of calling the widget
bindkey 'Ω' _fzf_z_widget

_fzf_zvim_widget() {
  local cmd="fasd -Rfl"

  if [[ -n "$LBUFFER" ]]; then
    __fzf_buffer_match "$cmd"
    local ret=$?
    return $ret
  fi

  local file=$(__fzf_cmd "$cmd") 
  if [[ ! -f "$file" ]]; then
    zle redisplay
    return 1
  fi
  # `vim` spits "Warning: Input is not from a terminal" without the `<
  # /dev/tty`
  eval $EDITOR ${(q)file} < /dev/tty

  local ret=$?
  __zsh_add_history "$EDITOR ${(q)file}"
  __fzf_reset_finish
  return $ret
}
zle -N _fzf_zvim_widget
bindkey '\er' _fzf_zvim_widget


# Special

# Tags uses a special `fzf` command
_fzf_tags_widget() {
  local cmd="~/.bin/dump_tags"
  if [[ -n "$LBUFFER" ]]; then
    __fzf_buffer_match "$cmd"
    local ret=$?
    return $ret
  fi
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
zle -N _fzf_tags_widget
bindkey '\ei' _fzf_tags_widget

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
_fzf_command_widget() {
  local MATCH
  LBUFFER=${LBUFFER%%(#m)[_\-a-zA-Z0-9]#}
  LBUFFER+="$(__fcmd $MATCH)"
  local ret=$?
  zle redisplay
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}
zle     -N   _fzf_command_widget
# bindkey '^@' _fzf_command_widget
bindkey '\ex' _fzf_command_widget

_robenkleene_fzf_inline_result() {
  local list_cmd=${1-$FZF_DEFAULT_COMMAND}
  setopt localoptions pipefail 2> /dev/null
  local result="$(eval "$list_cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS" fzf +m)"
  local ret=$?
  echo $result
  return $ret
}

# Safari
fzf_safari_history_open() {
  local result=$(safari_history_dump \
    | FZF_DEFAULT_OPTS="-m --reverse --prompt \"Safari History> \" \
    --height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS" fzf +m \
    | cut -f2)
  if [[ -n $result ]]; then
    open "$result"
  fi
}

# Documentation
fzf_documentation_editor() {
  cd ~/Documentation/
  local query=$1
  if [[ -n "$query" ]]; then
    local list_cmd=$FZF_DEFAULT_COMMAND
    local result="$(eval "$list_cmd" "$query" | head -n 1)"
  else
    local result=$(_robenkleene_fzf_inline_result)
  fi
  if [[ -n "$result" ]]; then
    local parameter=$(printf '%q' "$PWD/$result")
    local final_cmd="$EDITOR $parameter"
    eval $final_cmd
    if [ $? -eq 0 ]; then
      # Add to history
      print -sr $final_cmd
    fi
  # else
  #   cd - >/dev/null
  fi
  cd - >/dev/null
}

# Snippets
fzf_snippet_copy() {
  cd ~/Development/Snippets/
  local result=$(_robenkleene_fzf_inline_result)
  if [[ -n $result ]]; then
    echo $result | tr '\n' '\0' | xargs -0 $BAT_COMMAND | tee /dev/tty | safecopy
  fi
  cd -
}
fzf_snippet_editor() {
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
  # else
  #   cd -
  fi
  cd -
}

# Xcode
if [[ "$(uname)" = "Darwin" ]]; then
  fzf_project_xcode() {
    setopt localoptions pipefail 2> /dev/null
    # find . -path '*.xcodeproj' -prune -o -name '*.xcworkspace' -o -name '*.xcodeproj' \
    fd xcodeproj \
      | grep -vE "\/Carthage\/" \
      | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --select-1 $FZF_DEFAULT_OPTS" fzf +m \
      | tr '\n' '\0' \
      | xargs -0 env -i open
  }
fi
if [[ "$(uname)" = "Darwin" ]]; then
  fzf_file_xcode() {
    local ack_search_xcode="$FZF_DEFAULT_COMMAND --glob \"*.swift\" --glob \"*.h\" --glob \"*.m\""
    eval $ack_search_xcode \
      | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS" fzf +m \
      | tr '\n' '\0' \
      | xargs -0 open -a "Xcode"
  }
fi

# ack
fzf_vim_grep() {
  FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --ansi $FZF_DEFAULT_OPTS" fzf +m | local result=`cat`
  echo $result | $VIM_COMMAND -c "GrepBuffer" -
}
fzf_vim_file() {
  FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --ansi $FZF_DEFAULT_OPTS" fzf +m | local result=`cat`
  $VIM_COMMAND $result -c ":bd"
}

fzf_tmux_vim_file() {
  tmux-paths -0 \
    | xargs -0 rg --files -g "" \
    | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --select-1 $FZF_DEFAULT_OPTS" fzf +m \
    | tr '\n' '\0' \
    | xargs -0 $VIM_COMMAND
}

fzf_tmux_window() {
  if [ -z "$TMUX" ]; then
    return
  fi
  local window=$(tmux list-windows | awk 'BEGIN{FS=" "} {print $1 $2}' | fzf | awk 'BEGIN{FS=":"} {print $1}')
  tmux select-window -t ":$window"
}
