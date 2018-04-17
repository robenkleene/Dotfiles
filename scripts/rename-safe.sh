#!/usr/bin/env bash

_get-title() {
  # `tr -dc '[:alnum:]\r\n. '`: Strip non-alphanumeric characters
  # `tr -s ' '`: Consolidate spaces to one space
  # `tr '[A-Z]' '[a-z]'`: Lowercase
  # `tr ' ' '-'`: Replace spaces with hyphens
  local result=$(echo "$1" | tr -dc '[:alnum:]\r\n.\-/ ' | tr -s ' ' | tr '[A-Z]' '[a-z]' | tr ' ' '-')
  local ret=$?
  echo $result
  return $ret
}

source ~/.bin/nobin/_rename-files.sh

_rename-files "$@"
