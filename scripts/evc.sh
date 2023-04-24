#!/usr/bin/env bash

set -e

eval "$EMACS_COMMAND -nw -eval \"(rk/vc-print-log-startup)\""
