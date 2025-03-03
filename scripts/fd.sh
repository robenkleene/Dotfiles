#!/usr/bin/env bash

set -euo pipefail

# Force fd to use default LS colors
# The default colors are hard to read on light backgrounds
LS_COLORS='' exec ~/.brew/bin/fd "$@"
