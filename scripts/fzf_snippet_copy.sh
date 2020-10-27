#!/usr/bin/env bash

set -eo pipefail

__fzfcmd() {
  [ -n "$TMUX_PANE" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "$FZF_TMUX_OPTS" ]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
}

cd ~/Developer/Snippets/ || return 1
cmd="fd --type f"
fzfcmd="$(__fzfcmd)"

result="$(eval "$cmd" | $fzfcmd)"
if [[ -n "$result" ]]; then
  parameter=$(printf '%q' "$PWD/$result")
  safecopy < "$parameter"
  final_cmd="$BAT_COMMAND $parameter"
  eval "$final_cmd"
fi
