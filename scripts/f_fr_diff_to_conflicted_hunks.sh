#!/usr/bin/env bash

set -euo pipefail

header=()
hunk=()
in_hunk=false
conflict_found=false

# Read from stdin
while IFS= read -r line; do
    if [[ "$line" =~ ^diff\ --git|^---|^\+\+\+ ]]; then
        # If we are starting a new file/section and the previous hunk had a conflict, print it
        if $conflict_found; then
            printf "%s\n" "${header[@]}"
            printf "%s\n" "${hunk[@]}"
            echo  # extra newline for separation
        fi
        
        # Reset for the new section
        header=("$line")
        hunk=()
        in_hunk=false
        conflict_found=false

    elif [[ "$line" =~ ^@@ ]]; then
        # If we are starting a new hunk, print the previous one if it had a conflict
        if $conflict_found; then
            printf "%s\n" "${hunk[@]}"
        fi

        # Start a new hunk
        hunk=("$line")
        in_hunk=true
        conflict_found=false

    else
        if $in_hunk; then
            hunk+=("$line")
            if [[ "$line" == *'<<<<<'* ]]; then
                conflict_found=true
            fi
        else
            header+=("$line")
        fi
    fi
done

# Check the last hunk in the input
if $conflict_found; then
    printf "%s\n" "${header[@]}"
    printf "%s\n" "${hunk[@]}"
fi
