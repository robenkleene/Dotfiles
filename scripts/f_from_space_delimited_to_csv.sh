#!/usr/bin/env bash

set -euo pipefail

~/.bin/f_strip | sed -E 's/[[:space:]]+/, /g'
