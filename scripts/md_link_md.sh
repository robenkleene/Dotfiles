#!/usr/bin/env bash

set -euo pipefail

while getopts ":t:h" option; do
  case "$option" in
    t)
      title="$OPTARG"
      ;;
    h)
      echo "Usage: command [-h] [-t <title>]"
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

if [[ -z "${title:-}" ]]; then
  text=$(cat)
  while read -r line; do
    if [[ -n "${title:-}" ]]; then
      echo "Only use line at a time" >&2
      exit 1
    fi
    title="$line"
  done <<< "$text"
fi

if [[ -z "$title" ]]; then
  echo "No valid title found" >&2
  exit 1
fi

make_file() {
  local filename=$1
  local contents=$2
  local temp_path
  temp_path=$(mktemp "$filename-XXXX")
  echo "$contents" >"$temp_path"
  mv -n "$temp_path" "$filename"
  if [[ -f "$temp_path" ]]; then
    echo -n "$temp_path"
  else
    echo -n "$filename"
  fi
}

contents="# $title"
slug=$(echo "$title" | ~/.bin/f_slug)
result=$(make_file "$slug.md" "$contents")
echo -n "[$title]($result)"
