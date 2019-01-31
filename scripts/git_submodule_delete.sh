#!/usr/bin/env bash

set -e

path=$1
if [[ ! -d "$path" ]]; then
  echo "Not a directory $path" >&2
  exit 1
fi

module_path=git/modules/$path
if [[ ! -d "$module_path" ]]; then
  echo "Not a directory $module_path" >&2
  exit 1
fi


git submodule deinit -f "$path"
rm -rf "$module_path"
git rm -f "$path"
