#!/usr/bin/env bash

set -eo pipefail

__fzfcmd() {
  [ -n "$TMUX_PANE" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "$FZF_TMUX_OPTS" ]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
}

cmd="rg --no-filename --only-matching \"\[([^\[\]]*)\]\((http.*?)\)\" ~/Text ~/Documentation"
fzfcmd="$(__fzfcmd)"

eval "$cmd" | $fzfcmd | ~/.bin/urls_open
