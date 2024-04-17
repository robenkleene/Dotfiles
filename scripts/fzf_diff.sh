#!/usr/bin/env zsh

set -euo pipefail

typeset -A file_to_diff

while read line; do
    if [[ $line == +++\ b\/* ]]; then
        file_path=${line:6}
        file_to_diff[$file_path]=""
    else
        if [[ -n ${file_path:-} ]]; then
            if [[ -n ${file_to_diff[$file_path]} ]]; then
                file_to_diff[$file_path]+=$'\n'
            fi
            file_to_diff[$file_path]+=$line
        fi
    fi
done < "${1:-/dev/stdin}"

echo "${(@k)file_to_diff}" | fzf --ansi --reverse --keep-right --multi --preview "bat --style=plain --color=always {}" \
  --bind="ctrl-e:execute(${EDITOR:-vim} {+}),ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down,ctrl-a:toggle-all" \
  --height=20 --preview-window=right,50%:wrap
