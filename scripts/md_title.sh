#!/usr/bin/env bash

set -euo pipefail

title=$(echo "$1" | ~/.bin/f_from_filename_to_title | tr -d '\n')
echo "# $title"
echo
