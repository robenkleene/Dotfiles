#!/usr/bin/env bash

set -euo pipefail

if ! command -v jq &> /dev/null; then
  echo "Error: jq is required but not installed" >&2
  exit 1
fi

snippets_dir="${HOME}/.config/Code/User/snippets"

for file in "$snippets_dir"/*.json; do
  lang=$(basename "$file" .json)
  [[ "$lang" = "package" ]] && continue
  jq -r --arg lang "$lang" '
    to_entries[] |
    .value as $v |
    (if ($v.prefix | type) == "array" then $v.prefix[] else $v.prefix end) as $pfx |
    "\($pfx)\t\($v.description)\t\($lang)"
  ' "$file"
done | sort | column -t -s $'\t'
