#!/usr/bin/env bash

set -euo pipefail

force="false"
while getopts ":p:fh" option; do
  case "$option" in
    p)
      file_path="$OPTARG"
      ;;
    f)
      force="true"
      ;;
    h)
      echo "Usage: command [-hf] [-p <file_path>]"
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

destination_dir="$HOME/.man/man9"
if [ ! -e "$destination_dir" ]; then
  mkdir -p "$destination_dir"
elif [ ! -d "$destination_dir" ]; then
  echo "Destination $destination_dir exist and it's not a directory" >&2
  exit 1
fi

source="$file_path"
filename=$(basename -- "$source")
filename="${filename%.*}"
title=$(echo "$filename" | awk '{print toupper($0)}')
dest="$destination_dir/$filename".9
if [[ -e "$dest" ]]; then
  if [[ "$force" == "true" ]]; then
    rm "$dest"
  else
    echo "Warning: Skipping $dest because it already exists, using $source" >&2
  fi
else
  pandoc --standalone --to man --from markdown <({ echo "% ${title}(9) Reference"; cat "$source"; }) --output "$dest"
fi
