#!/usr/bin/env bash

set -e

project_dir="$1"
if [[ ! -d "$project_dir" ]]; then
  project_dir=$(dirname "$1")
fi

# Remove leading and trailing slash and leading period
project_dir=${project_dir#\.}
project_dir=${project_dir#/}
project_dir=${project_dir%/}

destination_dir="$project_dir/../../archive/projects"

if [[ ! -d "$destination_dir" ]]; then
  echo "$destination_dir does not exist" >&2
  exit 1
fi

mv "$project_dir" "$destination_dir"
