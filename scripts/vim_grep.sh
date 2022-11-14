#!/usr/bin/env bash

set -e

exec ${VIM_COMMAND:=vim} -c "GrepBuffer" -
