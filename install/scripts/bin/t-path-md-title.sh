#!/usr/bin/env bash

set -euo pipefail

if [[ $# -eq 0 ]]; then
    input=$(cat)
else
    input="$1"
fi

title=$(echo "$input" | ~/.bin/t-path-txt-title | tr -d '\n')
echo "# $title"
echo
