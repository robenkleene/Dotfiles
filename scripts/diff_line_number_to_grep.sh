#!/usr/bin/env bash

set -euo pipefail

# `awk '{print $0}'` force a new line
awk '{print $0}' | while IFS= read -r line; do
  ~/.bin/f_from_diff_to_grep $line < "$1" | sed 's/$/: \n/'
done
