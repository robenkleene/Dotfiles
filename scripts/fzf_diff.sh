#!/usr/bin/env zsh

set -euo pipefail

tmp_file=$(mktemp)
tmp_file_ext="${tmp_file}.diff"
diff_file="$tmp_file_ext"
echo "${(@k)file_to_diff}" | fzf --ansi --reverse --keep-right --multi --preview "bat --style=plain --color=always {}" \
  --bind="ctrl-e:execute(${EDITOR:-vim} {+}),ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down,ctrl-a:toggle-all" \
  --height=20 --preview-window=right,50%:wrap
