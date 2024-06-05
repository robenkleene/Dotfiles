#!/usr/bin/env bash

set -euo pipefail

filename="false"
while getopts ":t:h" option; do
  case "$option" in
    t)
      title="$OPTARG"
      ;;
    h)
      echo "Usage: command [-h] [-t <title>] [-f <file-path>]"
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
  local destination_path=$1
  local contents=$3
  local temp_path
  temp_path=$(mktemp "$name-XXXX")
  echo "$contents" >"$temp_path"
  mv -n "$temp_path" "$destination_path"
  if [[ -f "$temp_path" ]]; then
    echo -n "$temp_path"
  else
    echo -n "$destination_path"
  fi
}

contents="# $title"
slug=$(echo "$title" | ~/.bin/f_slug)
result=$(make_file "$slug" "$dir" "$contents")
echo -n "[$title]($result)"
