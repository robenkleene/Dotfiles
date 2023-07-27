#!/usr/bin/env bash

set -euo pipefail

result=$(~/.bin/z_get "${1:-}")
~/.bin/fd_fzf "$result"
