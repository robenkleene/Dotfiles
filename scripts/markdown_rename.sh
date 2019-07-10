#!/usr/bin/env bash

set -e

slug="false"
while getopts ":p:sh" option; do
  case "$option" in
    p)
      file_path="$OPTARG"
      ;;
    s)
      slug="true"
      ;;
    h)
      echo "Usage: command [-hs] [-p <file_path>]"
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

old_file=$file_path
old_filename=$(basename "$old_file")
directory=$(dirname "$old_file")
if ! new_filename=$(~/.bin/markdown_filename "$old_file"); then
  echo "Error: Failed to get a new name" >&2
  exit 1
fi

if [[ "$slug" == "true" ]]; then
  if ! new_filename=$(echo "$new_filename" | ~/.bin/slug); then
    echo "Error: Failed to get a new name" >&2
    exit 1
  fi
fi

case $old_filename in
  *.*)
    extension="${old_filename##*.}"
    ;;
  *)
    extension="md"
    ;;
esac
new_filename=$new_filename.$extension
new_file=$directory/$new_filename

if [[ ! -f $new_file ]]; then
  mv "$old_file" "$new_file"
  echo "$new_file"
else
  echo "Error: $new_file already exists" >&2
  exit 1
fi
