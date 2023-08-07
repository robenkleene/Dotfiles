#!/usr/bin/env bash

set -euo pipefail

if [[ ! -f "$HOME/.personal" ]]; then
  exit 0
fi

echo "Auto"
sgitt -cp
