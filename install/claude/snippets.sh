#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "$0")/../.." && pwd)"
snippets_file="$repo_root/config/Code/User/snippets/markdown.json"
commands_dir="$repo_root/claude/commands"

mkdir -p "$commands_dir"
# Remove previously generated `rk-pr-` commands before regenerating
rm -f "$commands_dir"/rk-pr-*.md

jq -r '
  to_entries[]
  | select(.value.prefix | startswith("rk_pr_"))
  | [.value.prefix, .value.body, .value.description]
  | @tsv
' "$snippets_file" | while IFS=$'\t' read -r prefix body description; do
  # `tr '_' '-'` converts underscores to hyphens for command naming
  name="${prefix//_/-}"
  cat > "$commands_dir/$name.md" <<EOF
---
name: $name
description: $description
user-invocable: true
---

$body
EOF
done
