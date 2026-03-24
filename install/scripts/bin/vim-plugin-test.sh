#!/usr/bin/env bash

set -euo pipefail

# contents="set runtimepath^=$PWD
# set runtimepath+=$PWD
#
# filetype plugin indent on
# syntax enable"
#
# temp_path=$(mktemp "$filename-XXXX")
# echo "$contents" >"$temp_path"
# rm "$temp_path"
flags="-u NONE --noplugin -i NONE --cmd 'set runtimepath=$PWD"
exec $@ $flags
