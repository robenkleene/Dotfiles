#!/usr/bin/env bash

export LANG=C
export LC_CTYPE=C

set -euo pipefail

input=$(cat)
echo "$input" | pandoc --standalone -f markdown -t rtf | ~/.bin/safecopy
echo "$input"
