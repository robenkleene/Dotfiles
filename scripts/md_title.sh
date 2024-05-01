#!/usr/bin/env bash

set -euo pipefail

title=$(echo "$1" | ~/.bin/f_fr_filename_to_title | tr -d '\n')
echo "# $title"
echo
