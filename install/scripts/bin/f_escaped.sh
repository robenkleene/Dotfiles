#!/usr/bin/env zsh

set -euo pipefail

x=$(cat)
echo ${(q)x}
