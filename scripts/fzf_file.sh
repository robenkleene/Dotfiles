#!/usr/bin/env bash

set -euo pipefail

exec fzf --ansi --reverse --keep-right --multi --preview "bat --style=plain --color=always {}" \
  --bind="alt-e:execute(${EDITOR:-vim} {+}),ctrl-v:preview-page-up,alt-v:preview-page-down,alt-a:toggle-all" \
  --height=20 --preview-window=right,50%:wrap
