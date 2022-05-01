#!/usr/bin/env bash

set -euo pipefail

__fzfcmd() {
  [ -n "${TMUX_PANE:-0}" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "${FZF_TMUX_OPTS:-0}" ]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
}

cmd="tac $HOME/.clipboard_history"
fzfcmd="$(__fzfcmd)"

result="$(eval "$cmd" | $fzfcmd)"
if [[ -n "$result" ]]; then
  echo "$result" | ~/.bin/safecopy -s
fi
