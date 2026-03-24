#!/usr/bin/env bash

set -euo pipefail

# Convert space-delimited to `.csv`
~/.bin/f-strip | sed -E 's/[[:space:]]+/, /g'
