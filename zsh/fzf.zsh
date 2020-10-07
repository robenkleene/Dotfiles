export FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git --exclude .DS_Store'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'

# These set bindings, so don't import them
# source ~/.fzf/shell/completion.zsh
# source ~/.fzf/shell/key-bindings.zsh
# Need this function though:
__fzfcmd() {
  [ -n "$TMUX_PANE" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "$FZF_TMUX_OPTS" ]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
}

# Widgets

_fzf_cd_widget() {
  setopt localoptions pipefail 2> /dev/null

  if [[ ! $PWD = $HOME/* ]]; then
    echo "Only use in a subdirectory of home" >&2
    zle redisplay
    return 1
  fi

  local cmd=$FZF_ALT_C_COMMAND
  local fzfcmd
  fzfcmd="$(__fzfcmd)"

  # This snipper makes it so if you start adding a path, then the fzf input is
  # only at that path. E.g., ls dir/ then entering the command would only
  # select from dir/. This is disabled because I haven't been using it.
  # if [[ -n "$LBUFFER" ]]; then
  #   local dir="${LBUFFER##* }"
  #   if [[ -d "$dir" ]]; then
  #     cmd="cd $dir && $cmd && cd - >/dev/null"
  #   fi
  # fi

  local result
  result="$(eval "$cmd" | $fzfcmd)"
  local ret=$?

  if [[ ! -d "$result" ]]; then
    zle redisplay
    return $ret
  fi

  if [[ -n "$LBUFFER" ]]; then
    LBUFFER+=$result
    zle redisplay
    return $ret
  fi

  cd "$result" || return 1
  local result_parameter
  result_parameter=${(q)result}
  print -sr -- "cd $result_parameter"
  zle reset-prompt
  return $ret
}
zle -N _fzf_cd_widget
bindkey '\ec' _fzf_cd_widget

_fzf_editor_widget() {
  setopt localoptions pipefail 2> /dev/null

  if [[ ! $PWD = $HOME/* ]]; then
    echo "Only use in a subdirectory of home" >&2
    zle redisplay
    return 1
  fi

  local cmd=$FZF_CTRL_T_COMMAND
  local fzfcmd
  fzfcmd="$(__fzfcmd)"

  # This snipper makes it so if you start adding a path, then the fzf input is
  # only at that path. E.g., ls dir/ then entering the command would only
  # select from dir/. This is disabled because I haven't been using it.
  # if [[ -n "$LBUFFER" ]]; then
  #   local dir="${LBUFFER##* }"
  #   if [[ -d "$dir" ]]; then
  #     cmd="cd $dir && $cmd && cd - >/dev/null"
  #   fi
  # fi

  local result
  result="$(eval "$cmd" | $fzfcmd)"
  local ret=$?

  if [[ ! -f "$result" ]]; then
    zle redisplay
    return $ret
  fi

  if [[ -n "$LBUFFER" ]]; then
    LBUFFER+=$result
    zle redisplay
    return $ret
  fi

  local result_parameter
  result_parameter=${(q)result}
  eval "$EDITOR $result_parameter" < /dev/tty
  print -sr -- "$EDITOR $result_parameter"
  zle reset-prompt
  return $ret
}
zle -N _fzf_editor_widget
bindkey '\ee' _fzf_editor_widget

_fzf_z_widget() {
  setopt localoptions pipefail 2> /dev/null

  local cmd="fasd -Rdl"
  local fzfcmd
  fzfcmd="$(__fzfcmd)"

  local result
  result="$(eval "$cmd" | $fzfcmd)"
  local ret=$?

  if [[ ! -d "$result" ]]; then
    zle redisplay
    return $ret
  fi

  if [[ -n "$LBUFFER" ]]; then
    LBUFFER+=$result
    zle redisplay
    return $ret
  fi

  cd "$result" || return 1
  local result_parameter
  result_parameter=${(q)result}
  print -sr -- "cd $result_parameter"
  zle reset-prompt
  return $ret
}
zle -N _fzf_z_widget
bindkey '\ez' _fzf_z_widget
# Work around what's probably a iTerm bug where if the first key press after a
# new window is created is calling a widget, sometimes the character is entered
# at the prompted instead of calling the widget
bindkey 'Ω' _fzf_z_widget

_fzf_developer_widget() {
  setopt localoptions pipefail 2> /dev/null

  local cmd="fd --type d --exclude .git . ~/Developer"
  local fzfcmd
  fzfcmd="$(__fzfcmd)"

  local result
  result="$(eval "$cmd" | $fzfcmd)"
  local ret=$?

  if [[ ! -d "$result" ]]; then
    zle redisplay
    return $ret
  fi

  if [[ -n "$LBUFFER" ]]; then
    LBUFFER+=$result
    zle redisplay
    return $ret
  fi

  cd "$result" || return 1
  local result_parameter
  result_parameter=${(q)result}
  print -sr -- "cd $result_parameter"
  zle reset-prompt
  return $ret
}
zle -N _fzf_developer_widget
bindkey '\eg' _fzf_developer_widget

_fzf_quick_widget() {
  setopt localoptions pipefail 2> /dev/null

  local cmd="fd --type d --exclude .git . ~/Text ~/Documents/Text/Notes ~/Documentation"
  local fzfcmd
  fzfcmd="$(__fzfcmd)"

  local result
  result="$(eval "$cmd" | $fzfcmd)"
  local ret=$?

  if [[ ! -d "$result" ]]; then
    zle redisplay
    return $ret
  fi

  if [[ -n "$LBUFFER" ]]; then
    LBUFFER+=$result
    zle redisplay
    return $ret
  fi

  cd "$result" || return 1
  local result_parameter
  result_parameter=${(q)result}
  print -sr -- "cd $result_parameter"
  zle reset-prompt
  return $ret
}
zle -N _fzf_quick_widget
bindkey '\eo' _fzf_quick_widget

_fzf_command_widget() {
  setopt localoptions pipefail 2> /dev/null

  local fzfcmd
  fzfcmd="$(__fzfcmd)"

  local commands=( "${(k)functions[@]}" "${(k)commands[@]}" )
  # There's a shell command called `g[` that `eval` has trouble parsing
  commands=("${(@)commands:#g\[}")
  local -x cmd="print -l \\"${commands[*]}\\" | grep -E -v \"^(_|VCS)\""

  local result
  result="$(eval "$cmd" | $fzfcmd)"
  local ret=$?
  if ! type "$result" > /dev/null; then
    zle redisplay
    return 0
  fi

  LBUFFER+="$result "
  zle redisplay
  return $ret
}
zle     -N   _fzf_command_widget
bindkey '\ex' _fzf_command_widget

# Functions

fzf_documentation_editor() {
  setopt localoptions pipefail 2> /dev/null

  cd ~/Documentation/ || return 1
  local cmd="fd --hidden --exclude .git --exclude .DS_Store"
  local fzfcmd
  fzfcmd="$(__fzfcmd)"

  local result
  result="$(eval "$cmd" | $fzfcmd)"
  if [[ -n "$result" ]]; then
    local parameter
    parameter=$(printf '%q' "$PWD/$result")
    if [[ -e "$parameter" ]]; then
      local final_cmd="$EDITOR $parameter"
      if eval "$final_cmd"; then
        print -sr "$final_cmd"
      fi
    fi
  fi
  cd - >/dev/null || return
}

fzf_documentation() {
  setopt localoptions pipefail 2> /dev/null

  cd ~/Documentation/ || return 1
  local cmd="fd --hidden --exclude .git --exclude .DS_Store"
  local fzfcmd
  fzfcmd="$(__fzfcmd)"

  local result
  result="$(eval "$cmd" | $fzfcmd)"
  if [[ -n "$result" ]]; then
    local parameter
    parameter=$(printf '%q' "$PWD/$result")
    if [[ -d "$parameter" ]]; then
      # Pop directory befor cd to not affect cd stack
      cd - >/dev/null || return
      cd "$parameter" || return
      return 0
    else
      local final_cmd="$BAT_COMMAND $parameter"
      if eval "$final_cmd"; then
        print -sr "$final_cmd"
      fi
    fi
  fi
  cd - >/dev/null || return
}

fzf_snippet_copy() {
  setopt localoptions pipefail 2> /dev/null

  cd ~/Developer/Snippets/ || return 1
  local cmd="fd --type f --hidden --exclude .git --exclude .DS_Store"
  local fzfcmd
  fzfcmd="$(__fzfcmd)"

  local result
  result="$(eval "$cmd" | $fzfcmd)"
  if [[ -n "$result" ]]; then
    local parameter
    parameter=$(printf '%q' "$PWD/$result")
    safecopy < "$parameter"
    final_cmd="$BAT_COMMAND $parameter"
    if eval "$final_cmd"; then
      print -sr "$final_cmd"
    fi
  fi
  cd - >/dev/null || return
}

fzf_snippet_editor() {
  setopt localoptions pipefail 2> /dev/null

  cd ~/Developer/Snippets/ || return 1
  local cmd="fd --type f --hidden --exclude .git --exclude .DS_Store"
  local fzfcmd
  fzfcmd="$(__fzfcmd)"

  local result
  result="$(eval "$cmd" | $fzfcmd)"
  if [[ -n "$result" ]]; then
    local parameter
    parameter=$(printf '%q' "$PWD/$result")
    local final_cmd="$EDITOR $parameter"
    if eval "$final_cmd"; then
      print -sr "$final_cmd"
    fi
  fi
  cd - >/dev/null || return
}

