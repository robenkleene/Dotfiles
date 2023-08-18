#!/usr/bin/env bash

set -euo pipefail

git difftool "$@"
# Support multiple files?
# input=$(cat)
# file=${input#*[A-Z?] }
# if [[ ${input:0:1} != "?" ]]; then
#   nvim "$file"
# else
#   git difftool "$file"
# fi
