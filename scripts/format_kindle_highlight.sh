#!/usr/bin/env bash

set -euo pipefail

write="false"
while getopts ":wh" option; do
  case "$option" in
    w)
      write="true"
      ;;
    h)
      echo "Usage: command [-hf] [-p <file_path>]"
      exit 0
      ;;
    :)
      echo "Option -OPTARG requires an argument" >&2
      exit 1
      ;;
    \?)
      echo "Invalid option: -OPTARG" >&2
      exit 1
      ;;
  esac
done
shift "$((OPTIND - 1))"

process() {
  local file="${1:-/dev/stdin}"
  local stored=""

  while read -r line; do
    line=$(echo -n "${line//[$'\t\r\n']/}")
    if [[ -z "${line// /}" ]]; then
      continue
    fi
    if [[ $line =~ ^LOCATION:[[:space:]]([0-9]+) ]]; then
      printf '`'
      echo -n "${BASH_REMATCH[1]}"
      printf '`:'
      echo
      echo
      echo "> ${stored}"
      echo
      stored=""
    elif [[ -n $stored ]]; then
      echo "# *${stored}* by ${line}"
      echo
      stored=""
    else
      stored+="$line"
    fi
  done <"${file}"
}

if [ $# -gt 0 ]; then
  for file in "$@"; do
    result=$(process $file)
    if [[ "$write" == "true" ]]; then
      title=$(head -n 1 "$file")
      slug=$(echo "$title" | ~/.bin/slug)
      source=$(mktemp "${slug}-XXXX")
      echo "$result" >>"$source"
      destination="${slug}.md"
      mv -n "$source" "$destination"
      if [[ -f "$source" ]]; then
        echo "$source"
      else
        echo "$destination"
      fi
    else
      echo "$result"
    fi
  done
else
  process
fi
