#!/usr/bin/env bash

set -euo pipefail

~/.bin/t-md-md-f-link | sed -n 's/.*(\(.*\)).*/\1/p' | grep -v '^http'
