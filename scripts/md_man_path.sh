#!/usr/bin/env bash

set -euo pipefail

if [[ -z "${1-}" ]]; then
  echo "Error: No name provided" >&2
  exit 1
fi

name="$1"

IFS='_' read -ra parts <<< "$name"
# Skip first component (rk prefix), use middle components as directories
# Guard and `${[@]+}` syntax avoid empty array being unbound under `set -u`
dir_parts=()
if (( ${#parts[@]} > 2 )); then
  dir_parts=("${parts[@]:1:${#parts[@]}-2}")
fi
dir_path=""
for part in "${dir_parts[@]+"${dir_parts[@]}"}"; do
  dir_path="${dir_path}${part}/"
done

rel_path="${dir_path}${name}.md"

cd "$(dirname "$(readlink "$0" 2>/dev/null || echo "$0")")"
cd ../install/man/markdown
# Handle cases like rk_vim where the sole component is both the directory
# and file (vim/rk_vim.md), not a file at the root (rk_vim.md)
if [[ ! -f "$rel_path" ]]; then
  # `${parts[-1]}` not supported in older bash, use `${#parts[@]}-1` instead
  last="${parts[${#parts[@]}-1]}"
  rel_path="${dir_path}${last}/${name}.md"
fi
~/.bin/path_abs "$rel_path"
