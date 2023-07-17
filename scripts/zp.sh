#!/usr/bin/env zsh

set -euo pipefail

~/.bin/safepaste | while IFS= read -r item; do
  echo -n "${(q)item} "
done
