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
  fzf --delimiter=':' --with-nth=3.. --ansi --reverse --keep-right \
  --preview 'bat --style=plain --color=always --line-range {2}: --highlight-line {2} {1}' \
  --bind="alt-e:execute(printf \"%s\n\" {+} | cut -d':' -f 2 | xargs bash -c 'f_from_diff_to_file \"\$@\" < "$tempfile"' _ | uniq | tr '\n' '\0' | xargs -0 -o ${EDITOR:-vim}),alt-g:execute(f_from_diff_to_arg {2} < {1} | xargs -o ${EDITOR:-vim}),ctrl-v:preview-page-up,alt-v:preview-page-down,alt-a:toggle-all" \
  --height=20 --preview-window=right,50%:wrap | cut -d':' -f 2)

if [[ -z "$EDITOR" || "$EDITOR" = "nvim" ]]; then
  awk -v start_line=$result '{ if (NR >= start_line) { if (/^---/) exit; if (/^@@/) printf "%s:%d:%s\n", FILENAME, NR, $0 } }' "$tempfile" | \
    fzf --delimiter=':' --with-nth=3.. --ansi --reverse --keep-right --multi \
    --preview 'bat --style=plain --color=always --line-range {2}: --highlight-line {2} {1}' \
    --bind="enter:become(echo {+} | cut -d':' -f 2 | diff_line_number_to_grep {1} | ${EDITOR:-vim} -c 'cbuffer | bprevious | bdelete' -),shift-up:preview-up,shift-down:preview-down,alt-a:select-all,alt-d:deselect-all" \
    --height=20 --preview-window=right,50%:wrap
else
  awk -v start_line=$result '{ if (NR >= start_line) { if (/^---/) exit; if (/^@@/) printf "%s:%d:%s\n", FILENAME, NR, $0 } }' "$tempfile" | \
    fzf --delimiter=':' --with-nth=3.. --ansi --reverse --keep-right \
    --preview 'bat --style=plain --color=always --line-range {2}: --highlight-line {2} {1}' \
    --bind="enter:become(f_from_diff_to_arg {2} < {1} | xargs -o ${EDITOR:-vim}),shift-up:preview-up,shift-down:preview-down" \
    --height=20 --preview-window=right,50%:wrap
fi
