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

# Print the associative array's contents
for key in "${(@k)file_to_diff}"; do
    echo "Key: $key"
    echo "Value: ${file_to_diff[$key]}"
    echo "-------------"
done
