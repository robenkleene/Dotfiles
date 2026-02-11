#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$(readlink "$0" 2>/dev/null || echo "$0")")"
cd ../install/man/markdown

find . -name 'rk_*.md' -type f | while read -r filepath; do
  rel="${filepath#./}"
  filename="$(basename "$rel" .md)"

  IFS='_' read -ra parts <<< "$filename"

  # Build expected directory path from middle components
  # `${[@]+}` syntax avoids empty array being unbound under `set -u`
  dir_parts=()
  if (( ${#parts[@]} > 2 )); then
    dir_parts=("${parts[@]:1:${#parts[@]}-2}")
  fi
  dir_path=""
  for part in "${dir_parts[@]+"${dir_parts[@]}"}"; do
    dir_path="${dir_path}${part}/"
  done

  primary="${dir_path}${filename}.md"
  # `${parts[-1]}` not supported in older bash, use `${#parts[@]}-1` instead
  last="${parts[${#parts[@]}-1]}"
  fallback="${dir_path}${last}/${filename}.md"

  if [[ "$rel" != "$primary" && "$rel" != "$fallback" ]]; then
    ~/.bin/path_abs "$rel"
  fi
done | sort
