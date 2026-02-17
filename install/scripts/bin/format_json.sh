#!/usr/bin/env bash

inplace="false"
while getopts ":p:ih" option; do
  case "$option" in
    p)
      file_path="$OPTARG"
      ;;
    i)
      inplace="true"
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

if [[ $# -eq 0 ]] ; then
  python -m json.tool
else
  if [[ -z "${file_path-}" ]]; then
    echo "Error: No file" >&2
    exit 1
  fi
  if [[ "$inplace" == "true" ]]; then
    echo "$(python -m json.tool "$file_path")" > "$file_path"
  else
    python -m json.tool "$file_path"
  fi
fi
