#!/usr/bin/env bash

_get_title() {
  local result
  result=$(echo "$1" | ~/.bin/f_to_slug)
  local ret=$?
  echo "$result"
  return $ret
}

source ~/.bin/nobin/_rename_files.sh

_rename_files "$@"
