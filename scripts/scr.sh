#!/usr/bin/env bash

set -euo pipefail

if git rev-parse --is-inside-work-tree &> /dev/null; then
    git rev-parse --show-toplevel
else
    hg root
fi

