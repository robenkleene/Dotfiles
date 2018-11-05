#!/usr/bin/env bash

set -e

source ~/.bin/nobin/_giterator.sh

find . -type d -execdir test -d "{}/.git" \; -print -prune | while read dir; do
  giterate "$dir"
done
