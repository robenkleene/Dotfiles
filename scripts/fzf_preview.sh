#!/usr/bin/env bash

set -eo pipefail

preview_opts="--preview '~/.bin/nobin/_fzf_preview.sh {}' --bind 'ctrl-f:preview-page-down,ctrl-b:preview-page-up,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' --preview-window '<30(bottom,30%)'"
__fzfcmd() {
  [ -n "$TMUX_PANE" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "$FZF_TMUX_OPTS" ]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} ${preview_opts} -- " || echo "fzf ${preview_opts}"
}
eval "$(__fzfcmd)"

