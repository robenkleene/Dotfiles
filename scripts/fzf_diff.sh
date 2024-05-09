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
result=$(grep --line-number --extended-regexp '^\+\+\+ b/' "$tempfile" /dev/null | \
  fzf --delimiter=':' --with-nth=3.. --ansi --keep-right \
  --preview 'bat --style=plain --color=always --line-range {2}: --highlight-line {2} {1}' | cut -d':' -f 2)

# `- 3` to get to the previous `diff --git` line
awk -v start_line=$result 'NR >= start_line - 3 { if (/^diff/) count++; if (count == 1) print; if (count == 2) exit; }' "$tempfile" | bat --style=plain
