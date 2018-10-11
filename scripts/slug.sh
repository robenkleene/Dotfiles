#!/usr/bin/env bash

today=$(date +%Y-%m-%d)
set -e

if [ "$#" -ne 1 ]; then
  echo "Wrong number of arguments" >&2
  exit 1
fi

safe_title=$(echo "$1" |
  tr -dc '[:alnum:]\r\n.\-/ ' |
  tr -s ' ' | tr '[A-Z]' '[a-z]' |
  tr ' ' '-')

echo $today-$safe_title
