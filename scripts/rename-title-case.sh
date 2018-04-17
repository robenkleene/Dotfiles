#!/usr/bin/env bash 

_get-title() {
  if [[ ! $filename_no_ext =~ ^[a-z0-9-]*$ ]]; then
    return 1
  fi
  script_dir=$(dirname $0)
  local result=$(echo "$1" | tr "-" " " | $script_dir/title-case)
  local ret=$?
  echo $result
  return $ret
}

source ~/.bin/nobin/_rename-files.sh

_rename-files "$@"
