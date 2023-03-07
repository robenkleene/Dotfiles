#!/usr/bin/env bash

set -euo pipefail

exec fd --strip-cwd-prefix --follow --hidden --max-depth 1 --exclude .DS_Store --exclude .git --exclude .hg
