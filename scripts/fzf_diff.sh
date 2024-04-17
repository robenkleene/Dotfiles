#!/usr/bin/env bash

set -euo pipefail

#!/bin/zsh

typeset -A file_to_diff

while read line; do
    if [[ $line == +++* ]]; then
        file_path=${line:3}
done < "${source_file:-/dev/stdin}"

# Iterate over lines to populate the associative array
for line in $lines; do
    if [[ $line == +++\ b\/* ]]; then
        file_path=${line:5}
        file_to_diff[$file_path]=""
    else
        # Append the line to the current key's value in the array
        if [[ -n $file_path ]]; then
            # Append the line with a newline unless it's the first line
            if [[ -n ${file_to_diff[$file_path]} ]]; then
                file_to_diff[$file_path]+=$'\n'
            fi
            file_to_diff[$file_path]+=$line
        fi
    fi
done

# Print the associative array's contents
for key in "${(@k)file_to_diff}"; do
    echo "Key: $key"
    echo "Value: ${file_to_diff[$key]}"
    echo "-------------"
done
