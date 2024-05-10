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

if [[ -z "${EDITOR:-}" || "${EDITOR:-}" = "nvim" ]]; then
  # `/dev/null` makes grep think it's dealing with multiple files, which forces it to print the filename
  grep --line-number --extended-regexp '^(\+|-)<<<<<<<' "$tempfile" /dev/null | fzf --delimiter=':' --with-nth=3.. --ansi --keep-right --multi \
    --preview 'bat --style=plain --color=always --line-range {2}: --highlight-line {2} {1}' \
    --bind="alt-e:execute(printf \"%s\n\" {+} | cut -d':' -f 2 | diff_line_number_to_grep {1} | ${EDITOR:-vim} -c 'cbuffer | bprevious | bdelete' -),alt-a:select-all,alt-d:deselect-all"
else
  # `/dev/null` makes grep think it's dealing with multiple files, which forces it to print the filename
  grep --line-number --extended-regexp '^(\+|-)<<<<<<<' "$tempfile" /dev/null | fzf --delimiter=':' --with-nth=3.. --ansi --keep-right \
    --preview 'bat --style=plain --color=always --line-range {2}: --highlight-line {2} {1}' \
    --bind="alt-e:execute(f_fr_diff_to_arg {2} < {1} | xargs -o ${EDITOR:-vim})"
fi
