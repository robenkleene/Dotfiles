#!/usr/bin/env bash

set -euo pipefail

echo "Auto"
if [[ -f "$HOME/.personal" ]]; then
  # Only automatically commit on personal machines
  sgitt -cp
else
  sgitt -p
fi
