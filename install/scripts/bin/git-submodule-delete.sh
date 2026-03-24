#!/usr/bin/env bash

set -e

usage() {
  echo "Usage: git_submodule_delete -p <PATH> [-f]"
}

force=false
while getopts ":p:fh" option; do
  case "$option" in
    p)
      path="$OPTARG"
      ;;
    f)
      force=true
      ;;
    h)
      usage
      exit 0
      ;;
    :)
      echo "Option -$OPTARG requires an argument" >&2
      exit 1
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

if [[ -z "$path" ]]; then
  echo "No path specified" >&2
  usage
  exit 1
fi

if [[ ! -d "$path" ]]; then
  echo "Not a directory $path" >&2
  usage
  exit 1
fi

module_path=".git/modules/$path"
if [[ ! -d "$module_path" ]]; then
  echo "Not a directory $module_path" >&2
  usage
  exit 1
fi

[[ "$force" == "false" ]] && echo "Dry Run"
echo "Deinit $path"
[[ "$force" == "true" ]] && git submodule deinit -f "$path"
echo "Delete $path"
[[ "$force" == "true" ]] && rm -rf "$module_path"
echo "Remove from git $path"
[[ "$force" == "true" ]] && git rm -f "$path"
