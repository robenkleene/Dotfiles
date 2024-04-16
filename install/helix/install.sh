#!/usr/bin/env bash

set -euo pipefail

source="$HOMEBREW_DIR/.brew/Cellar/helix/24.03/libexec/runtime" 
if [[ -d "$source" ]]; then
  ln -s $source ~/.config/helix/runtime
else
  echo "Error: $source does not exist" >&2
fi
