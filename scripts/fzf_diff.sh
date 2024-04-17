#!/usr/bin/env bash

set -euo pipefail

#!/bin/zsh

# Declare an associative array
typeset -A contentMap

# Read from STDIN into a variable
input=$(< /dev/stdin)

# Variable to keep track of the current key
currentKey=""

# Split input into lines
IFS=$'\n' read -r -d '' -A lines <<< "$input"

# Iterate over lines to populate the associative array
for line in $lines; do
    if [[ $line == +++* ]]; then
        # Extract the key, stripping off the leading '+++'
        currentKey=${line:3}
        # Initialize the current key in the associative array
        contentMap[$currentKey]=""
    else
        # Append the line to the current key's value in the array
        if [[ -n $currentKey ]]; then
            # Append the line with a newline unless it's the first line
            if [[ -n ${contentMap[$currentKey]} ]]; then
                contentMap[$currentKey]+=$'\n'
            fi
            contentMap[$currentKey]+=$line
        fi
    fi
done

# Print the associative array's contents
for key in "${(@k)contentMap}"; do
    echo "Key: $key"
    echo "Value: ${contentMap[$key]}"
    echo "-------------"
done
