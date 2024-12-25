#!/usr/bin/env bash

set -euo pipefail

~/.bin/f_fr_md_to_md_link "$1" | sed -n 's/.*(\(.*\)).*/\1/p' | grep -v '^http'