#!/usr/bin/env bash

set -euo pipefail

# For some reasons folds don't trigger unless we set `ft` twice?
exec ${VIM_COMMAND:=vim} -c "set ft=diff | set ft=diff" -
