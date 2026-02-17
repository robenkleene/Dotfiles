#!/usr/bin/env bash

set -euo pipefail

source ~/.bin/nobin/_giterator.sh

find . -type d -execdir test -d "{}/.git" \; -print -prune | while read -r dir; do
  giterate "$dir"
done
