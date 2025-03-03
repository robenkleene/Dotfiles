#!/usr/bin/env bash

set -euo pipefail

# Force fd to use default LS colors
# The default colors are hard to read on light backgrounds
exec LS_COLORS='' ~/.brew/bin/fd "$@"
