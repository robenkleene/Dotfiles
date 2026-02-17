#!/usr/bin/env bash

set -euo pipefail

# if [[ -e "$HOME/.bin-local/local_push" ]]; then
#   ~/.bin-local/local_push
# fi

if [[ ! -f "$HOME/.personal" ]]; then
  exit 0
fi

echo "Auto"
sgitt -cp
