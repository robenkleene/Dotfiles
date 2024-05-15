#!/usr/bin/env bash

set -euo pipefail

project_dir="$1"

if [[ ! -d "$project_dir" ]]; then
  project_dir=$(dirname "$1")
fi

if [[ -z "$project_dir" ]]; then
  echo "Error: No project directory specified" >&2
  exit 1
fi

if [[ ! -d "$project_dir" ]]; then
  echo "Error: No valid project directory found $project_dir" >&2
  exit 1
fi

# Remove leading and trailing slash and leading period
# Can't remove leading dot because that will break if already in the
# `project_dir` so the entire path is `.`
# project_dir=${project_dir#\.}
project_dir=${project_dir%/}

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
