#!/usr/bin/env bash

set -euo pipefail

title=$(echo "$1" | ~/.bin/t_path_txt_title | tr -d '\n')
echo "# $title"
echo
