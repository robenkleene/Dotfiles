#!/usr/bin/env bash

set -euo pipefail

~/.bin/rk-t-md-md-f-link | sed -n 's/.*(\(.*\)).*/\1/p' | grep -v '^http'
