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

if [[ -z "$EDITOR" || "$EDITOR" = "nvim" ]]; then
  echo "$file_lines" | fzf --delimiter=':' --with-nth=3.. --ansi --keep-right --multi \
    --preview 'bat --style=header --color=always --line-range {2}: --highlight-line {2} {1}' \
    --bind="alt-e:execute(printf \"%s\n\" {+} | ${EDITOR:-vim} -c 'cbuffer | bprevious | bdelete' -),alt-a:select-all,alt-d:deselect-all"
else
  echo "$file_lines" | fzf --delimiter=':' --with-nth=3.. --ansi --keep-right --multi \
    --preview 'bat --style=header --color=always --line-range {2}: --highlight-line {2} {1}' \
    --bind="alt-e:execute(${EDITOR:-vim} +{2} {1}),alt-a:select-all,alt-d:deselect-all"
fi
