#!/usr/bin/env bash

set -euo pipefail

tempfile=$(mktemp)
tempfile_ext="${tempfile}.diff"
if [[ ! -f "$tempfile_ext" ]]; then
  tempfile="$tempfile_ext"
fi

cleanup() {
  rm -f "$tempfile"
}

trap cleanup EXIT SIGINT SIGTERM

cat > "$tempfile"

# `/dev/null` makes grep think it's dealing with multiple files, which forces it to print the filename
grep --line-number --extended-regexp '^(\+\+\+ b\/|@@)' "$tempfile" /dev/null | fzf --delimiter=':' --with-nth=3.. --ansi --reverse --keep-right --multi \
  --preview 'bat --style=plain --color=always --line-range {2}: --highlight-line {2} {1}' \
  --bind="alt-e:execute(echo {+} | cut -d':' -f 2 | xargs bash -c 'f_from_diff_to_file \"\$@\" < "$tempfile"' _ | uniq | xargs ${EDITOR:-vim}),alt-g:execute(f_from_diff_to_arg {2} < {1} | xargs ${EDITOR:-vim}),ctrl-v:preview-page-up,alt-v:preview-page-down,alt-a:toggle-all" \
  --height=20 --preview-window=right,50%:wrap
