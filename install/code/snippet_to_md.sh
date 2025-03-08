#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 <json-file>"
  exit 1
fi

src="$1"
dst="$2"
lang=$(basename "${src%.*}")

jq -r --arg lang "$lang" '
  to_entries[] | 
  "# \(.key)\n\n\(.value.description)\n\n``` \($lang)\n\(.value.body)\n```"
' "$src" >> "$dst"