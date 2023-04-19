#!/usr/bin/env bash

set -euo pipefail

exec ${VIM_COMMAND:=vim} -c "set ft=diff" -
