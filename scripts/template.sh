#!/usr/bin/env bash

set -euo pipefail

path="$1"
extension="${path##*.}"

template=$(find ~/Developer/Snippets/Templates -type f -name "Template.${extension}" | tail -1)
if [[ -z $template ]]; then
  echo "Error: No template found for $extension" >&2
  exit 1
fi

cat "$template"
