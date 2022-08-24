#!/usr/bin/env bash

set -euo pipefail

sed 's/^stderr: //' | sed 's/^\([^ ]*\)(\([0-9]*\),\([0-9]*\)):/\1:\2:\3/'
#                     ^ Unity errors
