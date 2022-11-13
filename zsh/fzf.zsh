export FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS"

# These set bindings, so don't import them
# source ~/.fzf/shell/completion.zsh
# source ~/.fzf/shell/key-bindings.zsh
# Need this function though:
__fzfcmd() {
  [ -n "$TMUX_PANE" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "$FZF_TMUX_OPTS" ]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
}

# Widgets

_fzf_z_widget() {
  setopt localoptions pipefail 2> /dev/null

  local cmd="zoxide query --list"
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

_fzf_cd_widget() {
  setopt localoptions pipefail 2> /dev/null

  local cmd="fd --strip-cwd-prefix --type d --hidden --follow --max-depth 1 --exclude .git --exclude .hg"
  if [[ ! $PWD = $HOME/* ]]; then
    cmd="$cmd --maxdepth 1"
  fi

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
zle -N _fzf_cd_widget
bindkey '\ec' _fzf_cd_widget

_fzf_editor_widget() {
  setopt localoptions pipefail 2> /dev/null

  local cmd="fd --strip-cwd-prefix --type f --follow --type l --hidden --max-depth 1 --exclude .DS_Store"
  if [[ ! $PWD = $HOME/* ]]; then
    cmd="$cmd --maxdepth 1"
  fi

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
  zle accept-line
  return $ret
}
zle -N _fzf_editor_widget
bindkey '\eo' _fzf_editor_widget
