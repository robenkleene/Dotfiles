#!/usr/bin/env bash

set -euo pipefail

# Convert space-delimited to `.csv`
~/.bin/f_strip | sed -E 's/[[:space:]]+/, /g'
