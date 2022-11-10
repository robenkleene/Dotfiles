export FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS"
# Note this returns files and symlinks, regardless of whether they're
# directories, when really we probably want files or symlinks to files
export FZF_DEFAULT_COMMAND='fd --type f --follow --type l --hidden --exclude .git --exclude .hg --exclude .DS_Store'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
# We don't return symlinks here because you can't cd to symlinks to files
export FZF_ALT_C_COMMAND='fd --type d --follow --hidden --exclude .git --exclude .hg'

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

  local cmd=$FZF_ALT_C_COMMAND
  if [[ ! $PWD = $HOME/* ]]; then
    cmd="$cmd --maxdepth 1"
  fi

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
    return
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
# Visual Studio Code prints this character for this binding
bindkey 'ç' _fzf_cd_widget

_fzf_editor_widget() {
  setopt localoptions pipefail 2> /dev/null

  local cmd=$FZF_CTRL_T_COMMAND
  if [[ ! $PWD = $HOME/* ]]; then
    cmd="$cmd --maxdepth 1"
  fi

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
    return
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
  # accept-line instantly adds to history, reset-prompt requires hitting return
  # zle reset-prompt
  zle accept-line
  return $ret
}
zle -N _fzf_editor_widget
bindkey '\eo' _fzf_editor_widget
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
    return
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

  local cmd="find ~/Developer -type d -exec test -e '{}/.git' ';' -print -prune"
  # local cmd="fd --type d . ~/Developer"
  local fzfcmd
  fzfcmd="$(__fzfcmd)"

  local result
  result="$(eval "$cmd" | $fzfcmd)"
  local ret=$?

  if [[ ! -d "$result" ]]; then
    zle redisplay
    return
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
# Visual Studio Code prints this character for this binding
bindkey '©' _fzf_developer_widget

_fzf_quick_widget() {
  setopt localoptions pipefail 2> /dev/null
  local cmd="fd --type d --follow . ~/Text ~/Documentation"

  local fzfcmd
  fzfcmd="$(__fzfcmd)"

  local result
  result="$(eval "$cmd" | $fzfcmd)"
  local ret=$?

  if [[ ! -d "$result" ]]; then
    zle redisplay
    return
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
# bindkey '\eo' _fzf_quick_widget
# Visual Studio Code prints this character for this binding
# bindkey 'ø' _fzf_quick_widget

_fzf_quick_files_widget() {
  setopt localoptions pipefail 2> /dev/null
  local cmd="fd --type f --follow . ~/Text ~/Documentation"

  local fzfcmd
  fzfcmd="$(__fzfcmd)"

  local result
  result="$(eval "$cmd" | $fzfcmd)"
  local ret=$?

  if [[ ! -f "$result" ]]; then
    zle redisplay
    return
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
  # accept-line instantly adds to history, reset-prompt requires hitting return
  # zle reset-prompt
  zle accept-line
  return $ret
}
zle -N _fzf_quick_files_widget
bindkey '\eO' _fzf_quick_files_widget
bindkey '^o' _fzf_quick_files_widget

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
    return
  fi

  LBUFFER+="$result "
  zle redisplay
  return $ret
}
zle     -N   _fzf_command_widget
bindkey '\ex' _fzf_command_widget
# Visual Studio Code prints this character for this binding
bindkey '≈' _fzf_command_widget

# Functions

fzf_documentation_edit() {
  cd ~/Documentation/ || return 1
  local cmd="fd --follow \"^[^.]+\\\$|.*\\.md\""
  local fzfcmd="$(__fzfcmd)"

  local result="$(eval "$cmd" | $fzfcmd)"
  if [[ -z "$result" ]]; then
    exit
  fi

  parameter=$(printf '%q' "$PWD/$result")
  if [[ -e "$parameter" ]]; then
    if [[ -d "$parameter" ]]; then
      cd "$parameter"
    else
      final_cmd="$EDITOR $parameter"
      eval "$final_cmd"
    fi
  fi
}

fzf_documentation_less() {
  cd ~/Documentation/ || return 1
  local cmd="fd --type f --follow -g \"*.md\""
  local fzfcmd="$(__fzfcmd)"

  local result="$(eval "$cmd" | $fzfcmd)"
  if [[ -z "$result" ]]; then
    exit
  fi

  local parameter=$(printf '%q' "$PWD/$result")
  if [[ -f "$parameter" ]]; then
    local final_cmd="$CAT_COMMAND $parameter"
    eval "$final_cmd"
  fi
}
