#!/usr/bin/env bash

filename=$(basename "$1")
filename_no_ext=${filename%.*}
script_dir=$(dirname "$0")
if [[ $filename_no_ext =~ ^[a-z0-9_-]*$ ]]; then
# If the filename contains only lowercase letters, hyphens, and underscores then assume
# convert it to title case with spaces.
title=$(echo "$filename_no_ext" | tr "-" " " | tr "_" " " | "$script_dir"/title_case)
else
title=$(echo "$filename_no_ext" | "$script_dir"/title_case)
fi

echo "# $title"
echo
