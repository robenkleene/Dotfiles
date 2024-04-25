#!/usr/bin/env bash

set -euo pipefail

if [[ -z "$EDITOR" || "$EDITOR" = "nvim" ]]; then
  exec fzf --delimiter=':' --nth=2.. --ansi --reverse --keep-right --multi \
    --preview 'bat --style=header --color=always --line-range {2}: --highlight-line {2} {1}' \
    --bind="enter:become(printf \"%s\n\" {+} | ${EDITOR:-vim} -c 'cbuffer | bprevious | bdelete' -),shift-up:preview-up,shift-down:preview-down,alt-a:select-all,alt-d:deselect-all" \
    --height=20 --preview-window=right,50%:wrap
else
  exec fzf --delimiter=':' --nth=2.. --ansi --reverse --keep-right \
    --preview 'bat --style=header --color=always --line-range {2}: --highlight-line {2} {1}' \
    --bind="enter:execute(${EDITOR:-vim} +{2} {1}),shift-up:preview-up,shift-down:preview-down,alt-a:select-all,alt-d:deselect-all" \
    --height=20 --preview-window=right,50%:wrap
fi
