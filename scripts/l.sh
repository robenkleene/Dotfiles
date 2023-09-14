#!/usr/bin/env bash

set -euo pipefail

if [[ ! -t 0 ]]; then
  rg --no-heading --with-filename --line-number --color=always 'https?://?([\da-z\.-]+)\.([a-z\.]{2,6})([/\w \.-]*)*/?' \
  | fzf -d ':' -n 2.. --ansi --reverse --keep-right --multi \
    --preview 'bat --style=plain --color=always --line-range {2}: --highlight-line {2} {1}' \
    --bind="alt-v:become(echo {+} | vim -c GrepBuffer -),alt-l:execute-silent(echo {+} | ~/.bin/f_a_txt_to_url_open)+accept,alt-t:execute-silent(echo {+} | ~/.bin/f_a_txt_to_url_open_in_safari_tabs)+accept,ctrl-x:execute-silent(~/.bin/print_args {+} | ~/.bin/safecopy)+accept,ctrl-u:preview-page-up,ctrl-d:preview-page-down,ctrl-a:toggle-all" \
    --height=20 --preview-window=right,50%:wrap
else
  exec rg --no-heading --with-filename --line-number --color=always 'https?://?([\da-z\.-]+)\.([a-z\.]{2,6})([/\w \.-]*)*/?' "$@" \
    | fzf -d ':' -n 2.. --ansi --reverse --keep-right --multi \
    --preview 'bat --style=plain --color=always --line-range {2}: --highlight-line {2} {1}' \
    --bind="alt-v:become(echo {+} | vim -c GrepBuffer -),alt-l:execute-silent(echo {+} | ~/.bin/f_a_txt_to_url_open)+accept,alt-t:execute-silent(echo {+} | ~/.bin/f_a_txt_to_url_open_in_safari_tabs)+accept,ctrl-x:execute-silent(~/.bin/print_args {+} | ~/.bin/safecopy)+accept,ctrl-u:preview-page-up,ctrl-d:preview-page-down,ctrl-a:toggle-all" \
    --height=20 --preview-window=right,50%:wrap
fi
