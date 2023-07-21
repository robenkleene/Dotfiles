#!/usr/bin/env bash

set -euo pipefail

if [[ -f "$1" ]]; then
  bat --style=plain --color=always "$1"
elif [[ -d "$1" ]]; then
  ls -Cp "$1"
fi
