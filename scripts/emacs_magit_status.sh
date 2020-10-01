#!/usr/bin/env bash

set -e

eval "$EMACS_COMMAND -nw -eval \"(robenkleene/magit-status-startup)\""
