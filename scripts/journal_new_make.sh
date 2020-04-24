#!/usr/bin/env bash

set -e

journal_directory="$1"
if [[ ! -d "$journal_directory" ]]; then
  echo "$journal_directory is not a directory" >&2
  exit 1
fi

# Remove trailing slash
journal_directory=${journal_directory%/}


today=$(date +%Y-%m-%d)
destination_entry_path="$journal_directory/$today.md"
if [[ -f "$destination_entry_path" ]]; then
  # Print the existing entry and return without error so scripts can simply say
  # "open today's entry" and open the result of this script.
  echo -n "$destination_entry_path"
  exit 0
fi

DaySuffix() {
  case $(date +%d) in
    01|21|31) echo "st";;
    02|22)    echo "nd";;
    03|23)    echo "rd";;
    *)       echo "th";;
  esac
}
header=$(date "+%A, %B %-d$(DaySuffix), %Y")
content="# $header"
last_entry=$(~/.bin/journal_newest "$journal_directory")
content+="
"
content+=$(tail -n +2 "$last_entry")

entry_path=$(mktemp "$journal_directory/$today-XXXX")
echo "$content" >"$entry_path"

mv -n "$entry_path" "$destination_entry_path"
if [[ -f "$entry_path" ]]; then
  echo -n "$entry_path"
else
  echo -n "$destination_entry_path"
fi
