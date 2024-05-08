#!/usr/bin/env bash

set -euo pipefail

exec fzf --ansi --reverse --keep-right --multi --preview "bat --style=plain --color=always {}" \
  --bind="enter:become(${EDITOR:-vim} {+}),alt-a:select-all,alt-d:deselect-all" \
  --height=20 --preview-window=right,50%:wrap
