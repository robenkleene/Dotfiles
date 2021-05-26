#!/usr/bin/env bash

set -e

exec ~/.bin/diff_to_grep | "$VIM_COMMAND" -c "GrepBuffer" -
