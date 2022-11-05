#!/usr/bin/env bash

set -euo pipefail

path="$1"
extension="${path##*.}"

if [[ "$extension" = "md" ]]; then
  exec ~/.bin/markdown_title "$1"
fi
