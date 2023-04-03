#!/usr/bin/env bash

set -e

eval "$EMACS_COMMAND -nw -eval \"(magit-status-startup)\""
