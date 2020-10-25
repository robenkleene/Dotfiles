#!/usr/bin/env bash

set -o pipefail

__fzfcmd() {
  [ -n "$TMUX_PANE" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "$FZF_TMUX_OPTS" ]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
}

cd ~/Documentation/ || return 1
cmd="fd --type f --hidden --exclude .git --exclude .DS_Store"
fzfcmd="$(__fzfcmd)"

result="$(eval "$cmd" | $fzfcmd)"
if [[ -z "$result" ]]; then
  exit
fi

parameter=$(printf '%q' "$PWD/$result")
if [[ -f "$parameter" ]]; then
  final_cmd="$EDITOR $parameter"
  eval "$final_cmd"
fi
