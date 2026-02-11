#!/usr/bin/env bash

set -euo pipefail

if [[ -z "${1-}" ]]; then
  echo "Error: No name provided" >&2
  exit 1
fi

name="$1"

IFS='_' read -ra parts <<< "$name"
# Skip first component (rk prefix), use middle components as directories
dir_parts=("${parts[@]:1:${#parts[@]}-2}")
dir_path=""
for part in "${dir_parts[@]}"; do
  dir_path="${dir_path}${part}/"
done

rel_path="${dir_path}${name}.md"

cd "$(dirname "$(readlink "$0" 2>/dev/null || echo "$0")")"
cd ../install/man/markdown
~/.bin/path_abs "$rel_path"
