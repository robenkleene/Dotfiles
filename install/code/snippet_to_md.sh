#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 <json-file>"
  exit 1
fi

file="$1"
lang=$(basename "${file%.*}")

jq -r --arg lang "$lang" '
  to_entries[] | 
  "# \(.key)\n\n\(.value.description)\n\n``` \($lang)\n\(.value.body)\n```"
' "$file"