#!/usr/bin/env bash

set -euo pipefail

eval "$EMACS_COMMAND -eval \"(grep-from-clipboard-startup)\""
