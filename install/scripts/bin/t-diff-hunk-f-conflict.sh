#!/usr/bin/env bash

set -euo pipefail

header=()
hunk=()
in_hunk=false
conflict_found=false

while IFS= read -r line; do
    if [[ "$line" =~ ^diff\ --git ]]; then
        if $conflict_found; then
            printf "%s\n" "${header[@]}"
            printf "%s\n" "${hunk[@]}"
            echo
        fi
        
        header=("$line")
        hunk=()
        in_hunk=false
        conflict_found=false

    elif [[ "$line" =~ ^---|^\+\+\+ ]]; then
        header+=("$line")
    elif [[ "$line" =~ ^@@ ]]; then
        if $conflict_found; then
            printf "%s\n" "${header[@]}"
            printf "%s\n" "${hunk[@]}"
        fi
        hunk=("$line")
        in_hunk=true
        conflict_found=false

    else
        if $in_hunk; then
            hunk+=("$line")
            if [[ "$line" =~ ^\+\<\<\<\<\<|\+\|\|\|\|\|\|\||\+\<\<\<\<\<\<|\+====== ]]; then
                conflict_found=true
            fi
        fi
    fi
done

if $conflict_found; then
    printf "%s\n" "${header[@]}"
    printf "%s\n" "${hunk[@]}"
fi
