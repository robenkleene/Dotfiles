#!/usr/bin/env bash

set -euo pipefail

~/.bin/t_md_f_link | sed -n 's/.*(\(.*\)).*/\1/p' | grep -v '^http'
