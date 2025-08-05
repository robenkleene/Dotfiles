#!/usr/bin/env bash

set -euo pipefail

exec emacsclient --no-window-system "$@"
