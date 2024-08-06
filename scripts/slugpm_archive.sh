#!/usr/bin/env bash

set -euo pipefail

if [[ $# -eq 0 ]]; then
  text=$(cat)
  if [[ -z "${text:-}" ]]; then
    echo "Error: Nothing to archive" >&2
    exit 1
  fi
  destination_file="$PWD/archive/README.md"
  echo "$text" >>"$destination_file"
  exit 0
fi

for project_dir in "$@"; do
  # Remove leading and trailing slash and leading period
  # Can't remove leading dot because that will break if already in the
  # `project_dir` so the entire path is `.`
  # project_dir=${project_dir#\.}
  project_dir=${project_dir%/}

  if [[ ! -d "$project_dir" ]]; then
    echo -n "$project_dir isn't a directory" >&2
    exit 1
  fi

  destination_dir="$project_dir/../../archive/projects"

  if [[ ! -d "$destination_dir" ]]; then
    echo -n "$destination_dir does not exist" >&2
    exit 1
  fi

  # Convert o absolute path which helps in the case where current directory is
  # just `.`
  src_dir=$(cd "$project_dir" ; pwd)
  mv "$src_dir" "$destination_dir"
  # dir_name=$(basename "$src_dir")
  # echo -n "$destination_dir/$dir_name"
done
