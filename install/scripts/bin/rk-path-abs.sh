#!/usr/bin/env bash

set -euo pipefail

if [[ $# -gt 0 ]]; then
    paths=("$@")
elif [[ -t 0 ]]; then
    # Default to the current directory when there are no arguments and no input
    paths=("$PWD")
else
    paths=()
    # `|| [[ -n $line ]]` includes a last line without a trailing newline
    while IFS= read -r line || [[ -n $line ]]; do
        [[ -n $line ]] || continue
        paths+=("$line")
    done
fi

# `${#paths[@]}` check avoids `realpath` running with no arguments on empty input
[[ ${#paths[@]} -gt 0 ]] || exit 0

# `s| |\\\\ |g` escapes spaces with backslashes for shell-safe paths
realpath "${paths[@]}" | sed "s|^$HOME|~|; s| |\\\\ |g"
