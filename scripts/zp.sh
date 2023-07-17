#!/usr/bin/env zsh

set -euo pipefail

~/.bin/safepaste && echo | while IFS= read item; do
  echo -n "${(q)item} "
done
