#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$(readlink "$0" 2>/dev/null || echo "$0")")"
cd ../install/man/md

# Preferred abbreviations: "suffix=abbreviation"
abbreviations=(
  "command=cmd"
  "environment=env"
  "function=func"
  "initialization=init"
  "navigation=nav"
  "program=prog"
  "shell=sh"
  "string=str"
  "window=win"
)

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

  abs="$(pwd -P)/$rel"
  if [[ "$rel" != "$primary" && "$rel" != "$fallback" ]]; then
    echo "$abs"
  fi
  # Skip short words (< 4 chars) like `ops` that are likely abbreviations, not plurals
  if [[ "$last" == *s && ${#last} -ge 4 ]]; then
    echo "Warning: plural $abs"
  fi
  if [[ "$last" == *ing ]]; then
    echo "Warning: -ing suffix $abs"
  fi
  for entry in "${abbreviations[@]}"; do
    suffix="${entry%%=*}"
    abbrev="${entry#*=}"
    if [[ "$last" == *"$suffix" ]]; then
      echo "Warning: use '$abbrev' instead of '$suffix' $abs"
    fi
  done
done | sort
