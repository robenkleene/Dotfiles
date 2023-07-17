#!/usr/bin/env zsh

set -euo pipefail

~/.bin/safepaste | while IFS= read item; do
  echo -n "${(qq)item} "
done
