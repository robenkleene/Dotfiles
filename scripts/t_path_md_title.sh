#!/usr/bin/env bash

set -euo pipefail

if [[ $# -eq 0 ]]; then
    input=$(cat)
else
    input="$1"
fi

title=$(echo "$input" | ~/.bin/t_path_txt_title | tr -d '\n')
echo "# $title"
echo
