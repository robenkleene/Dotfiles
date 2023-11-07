#!/usr/bin/env bash

set -euo pipefail

# Override LESS because some nnn commands use LESS and options like
# --quit-if-one-screen interfere because they don't pause at the end
# -e: Use $VISUAL by default to edit text files
# -Q: Don't confirm on quit with multiple contexts active
# -A: Don't auto-enter directories
exec export LESS="" nnn -eAQ
