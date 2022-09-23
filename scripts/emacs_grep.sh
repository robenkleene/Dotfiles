#!/usr/bin/env bash

set -euo pipefail

eval "$EMACS_COMMAND -nw -eval \"(robenkleene/grep-from-clipboard)\""
