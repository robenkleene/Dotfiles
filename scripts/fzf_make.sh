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
results=$(grep --line-number --extended-regexp "[^: ]+:[0-9]+:?[0-9]+:?" "$tempfile" /dev/null)
file_lines=""
while IFS= read -r line; do
  file_path=$(echo "$line" | cut -d':' -f3)
  if [[ -f "$file_path" ]]; then
    file_lines+="$line"$'\n'
  fi
done <<< "$results"

echo "$file_lines" | fzf --delimiter=':' --with-nth=3.. --ansi --reverse --keep-right --multi \
  --preview 'bat --style=plain --color=always --line-range {2}: --highlight-line {2} {1}' \
  --bind="enter:become(${EDITOR:-vim} +{4} {3})+accept,alt-g:execute(${EDITOR:-vim} +{4} {3}),ctrl-v:preview-page-up,alt-v:preview-page-down,alt-a:toggle-all" \
  --height=20 --preview-window=right,50%:wrap
