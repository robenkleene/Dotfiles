#!/usr/bin/env bash

set -euo pipefail

exec $VIM_COMMAND $(~/.bin/daily_file)
