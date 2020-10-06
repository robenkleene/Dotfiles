#!/usr/bin/env bash

set -euo pipefail

scratch_dir="$HOME/Developer/Scratch/Document"

while getopts ":f:e:h" option; do
  case "$option" in
    f)
      file_type="OPTARG"
      ;;
    e)
      extension="OPTARG"
      ;;
    h)
      echo "Usage: command [-h] [-f <file type>] [-e <extension>]"
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

if [[ -z "$file_type" ]]; then
  echo "Invalid file type $file_type" >&2
  exit 1
fi

if [[ -z "$extension" ]]; then
  echo "Invalid extension $extension" >&2
  exit 1
fi

# Remove period if it exists
extension=${extension#.}
scratch_file="$scratch_dir/$file_type.$extension"

if [[ ! -f "$scratch_file" ]]; then
  echo "Scratch file $scratch_file doesn't exist" >&2
  exit 1
fi

cat >> "$scratch_file"
echo -n "$scratch_file"
