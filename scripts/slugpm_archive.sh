#!/usr/bin/env bash

set -euo pipefail

project_dir="${1:-}"

if [[ -z "$project_dir" ]]; then
  text=$(cat)
fi

if [[ ! -d "$project_dir" && -z "${text:-}" ]]; then
  echo "Error: Nothing to archive" >&2
  exit 1
fi

if [[ ! -d "$project_dir" ]]; then
  project_dir="$PWD"
fi

# Remove leading and trailing slash and leading period
# Can't remove leading dot because that will break if already in the
# `project_dir` so the entire path is `.`
# project_dir=${project_dir#\.}
project_dir=${project_dir%/}

if [[ -z "${text:-}" ]]; then
  destination_dir="$project_dir/../../archive/projects"

  if [[ ! -d "$destination_dir" ]]; then
    echo -n "$destination_dir does not exist" >&2
    exit 1
  fi

  # Convert o absolute path which helps in the case where current directory is
  # just `.`
  src_dir=$(cd "$project_dir" ; pwd)
  mv "$src_dir" "$destination_dir"
  dir_name=$(basename "$src_dir")
  echo -n "$destination_dir/$dir_name"
else
  destination_file="$project_dir/archive/README.md"
  echo "$text" >>"$destination_file"
fi
