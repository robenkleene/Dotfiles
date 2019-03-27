#!/usr/bin/env bash

set -e

journal_directory="$1"
if [[ ! -d "$journal_directory" ]]; then
  echo "$journal_directory is not a directory" >&2
  exit 1
fi

today=$(date +%Y-%m-%d)
destination_entry_path="$journal_directory/$today.md"
if [[ -f "$destination_entry_path" ]]; then
  echo "An entry already exists at $destination_entry_path" >&2
  exit 1
fi

DaySuffix() {
  case $(date +%d) in
    1|21|31) echo "st";;
    2|22)    echo "nd";;
    3|23)    echo "rd";;
    *)       echo "th";;
  esac
}
header=$(date "+%A, %B %-d$(DaySuffix), %Y")
content="# $header"
last_entry_filename=$(ls "$journal_directory" | tail -n 1 | tr -d '\n')
last_entry="$journal_directory/$last_entry_filename"
content+="
"
content+=$(tail -n +2 "$last_entry")

entry_path=$(mktemp "$journal_directory/$today-XXXX")
echo "$content" >"$entry_path"

mv -n "$entry_path" "$destination_entry_path"
if [[ -f "$entry_path" ]]; then
  echo -n $entry_path
else
  echo -n $destination_entry_path
fi
