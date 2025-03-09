#!/usr/bin/env bash

set -euo pipefail

if [[ $# -eq 0 ]]; then
  # `text=$(cat)` was giving problems with input shorter than one line
  text="$(</dev/stdin)"
  if [[ -z "${text:-}" ]]; then
    echo "Error: Nothing to archive" >&2
    exit 1
  fi
  filename="README.md"
  destination_file="$PWD/archive/$filename"
  if [[ ! -f "$destination_file" ]]; then
    echo "Error: $destination_file is not a file" >&2
  fi
  echo "$text" >>"$destination_file"
  exit 0
fi

for file_path in "$@"; do
  # Remove leading and trailing slash and leading period
  # Can't remove leading dot because that will break if already in the
  # `file_path` so the entire path is `.`
  # file_path=${file_path#\.}
  file_path=${file_path%/}

  if [[ -d "$file_path" && -d "$file_path/../projects/" && -f "$file_path/README.md" ]]; then
    # If it's a directory with a parent `projects` and a `README` treat as a project
    destination_dir="$file_path/../../archive/projects/"

    if [[ ! -d "$destination_dir" ]]; then
      echo "$destination_dir does not exist" >&2
      exit 1
    fi

    # Convert an absolute path which helps in the case where current directory
    # is just `.`
    src_dir=$(
      cd "$file_path"
      pwd
    )
    mv "$src_dir" "$destination_dir"
  else
    # If it's not a project, treat it as a single file
    if [[ -d "$file_path" ]]; then
      # Convert an absolute path which helps in the case where current
      # directory is just `.`
      file_path=$(
        cd "$file_path"
        pwd
      )
      destination_dir="$file_path/../../archive/"
    else
      destination_dir="$(dirname $file_path)/archive/"
    fi
    if [[ ! -d "$destination_dir" ]]; then
      echo "$destination_dir does not exist" >&2
      exit 1
    fi
    mv "$file_path" "$destination_dir"
  fi
done
