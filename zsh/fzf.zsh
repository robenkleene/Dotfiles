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

