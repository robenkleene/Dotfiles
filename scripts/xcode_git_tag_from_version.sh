#!/usr/bin/env bash

set -e

force=false
while getopts ":fh" option; do
  case "$option" in
    f)
      force=true
      ;;
    h)
      echo "Usage: command [-hf]"
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

# `cd` to repo root
cd "$(git rev-parse --show-toplevel)"

if [[ ! -d .git ]]; then
  echo "Not in a git repo" >&2
  exit 1
fi

app_version=$(agvtool what-marketing-version -terse1 | tr -d '\n')
if [[ ! "$app_version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Not a valid app version ${app_version}asdf" >&2
  exit 1
fi

if git rev-parse "$app_version" >/dev/null 2>&1; then
  echo "Tag $app_version already exists" >&2
  exit 1
fi

if $force; then
  git tag $app_version
fi
echo $app_version
