export FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS"

# These set bindings, so don't import them
# source ~/.fzf/shell/completion.zsh
# source ~/.fzf/shell/key-bindings.zsh
# Need this function though:
__fzfcmd() {
  [ -n "$TMUX_PANE" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "$FZF_TMUX_OPTS" ]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
}

_fzf_z_widget() {
  setopt localoptions pipefail 2> /dev/null

  local result
  result="$(~/.bin/z_fzf)"
  if (( $? )) then
    zle reset-prompt
    return $ret
  fi
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

_fzf_z_subdir_widget() {
  setopt localoptions pipefail 2> /dev/null

  local result
  result="$(~/.bin/z_fzf_subdir)"
  if (( $? )) then
    zle reset-prompt
    return $ret
  fi
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
zle -N _fzf_z_subdir_widget
bindkey '\ec' _fzf_z_subdir_widget

_fzf_z_parentdir_widget() {
  setopt localoptions pipefail 2> /dev/null

  local result
  result="$(~/.bin/z_fzf_parentdir)"
  if (( $? )) then
    zle reset-prompt
    return $ret
  fi
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
zle -N _fzf_z_parentdir_widget
bindkey '\e-' _fzf_z_parentdir_widget

_fzf_open_widget() {
  setopt localoptions pipefail 2> /dev/null

  local cmd="~/.bin/find_ls -f"
  if [[ ! $PWD = $HOME/* ]]; then
    cmd="$cmd --maxdepth 1"
  fi

  local fzfcmd
  fzfcmd="$(__fzfcmd)"

  local result
  result="$(eval "$cmd" | ~/.bin/fzf_file)"
  if (( $? )) then
    zle reset-prompt
    return $ret
  fi
  local ret=$?

  local result_parameter
  result_parameter=$(while IFS= read item; do
      echo -n "${(q)item} "
    done <<< "$result")

  if [[ -n "$LBUFFER" ]]; then
    LBUFFER+=$result_parameter
    zle redisplay
    return $ret
  fi

  if [[ -d "$result" ]]; then
    cd "$result" || return 1
    print -sr -- "cd $result_parameter"
  else
    eval "$EDITOR $result_parameter" < /dev/tty
    print -sr -- "$EDITOR $result_parameter"
  fi
  zle accept-line
  return $ret
}
zle -N _fzf_open_widget
bindkey '\eo' _fzf_open_widget
