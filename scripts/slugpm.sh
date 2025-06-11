#!/usr/bin/env bash

set -euo pipefail

if [[ "${1:-}" = "archive" ]]; then
  args="${@:2}"
  if [[ $# -eq 1 ]]; then
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

  for file_path in "$args"; do
    # Remove leading and trailing slash and leading period
    # Can't remove leading dot because that will break if already in the
    # `file_path` so the entire path is `.`
    # file_path=${file_path#\.}
    file_path=${file_path%/}

    if [[ -d "$file_path" && -d "$file_path/../../projects/" && -f "$file_path/README.md" ]]; then
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
  exit 0
fi

while getopts ":t:h" option; do
  case "$option" in
    t)
      title="$OPTARG"
      ;;
    h)
      echo "Usage: command [-hl] [-t <title>] [-d <directory>]"
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

if [[ -z "${title:-}" ]]; then
  text=$(cat)
  while read -r line; do
    if [[ -n "${title:-}" ]]; then
      echo "Only use line at a time" >&2
      exit 1
    fi
    title="$line"
  done <<< "$text"
fi

if [[ -z "$title" ]]; then
  echo "No valid title found" >&2
  exit 1
fi

dir="projects"

if [[ -n "$dir" ]]; then
  # Remove leading and trailing slash and leading period
  dir=${dir#\.}
  dir=${dir#/}
  dir=${dir%/}
  if [[ -e "$dir" ]] && [[ ! -d "$dir" ]]; then
    echo "$pwd/$dir exists and is not a dir" >&2
    exit 1
  elif [[ ! -e "$dir" ]]; then
    echo "$PWD/$dir does not exist" >&2
    exit 1
  fi
  # Don't try to always create this, just exit, this helps fail if the current
  # directoy is unexpected, which is a common mistake.
  # mkdir -p "$dir"
  cd "$dir"
fi

make_file() {
  local name=$1
  local dir=$2
  local contents=$3
  if [[ -e "$dir" ]] && [[ ! -d "$dir" ]]; then
    echo "$dir is not a directory" >&2
    exit 1
  else
    mkdir -p "$dir"
  fi
  mkdir -p "$dir"
  local temp_path
  temp_path=$(mktemp "$dir/$name-XXXX")
  echo "$contents" >"$temp_path"
  local destination_path="$dir/$name"
  mv -n "$temp_path" "$destination_path"
  if [[ -f "$temp_path" ]]; then
    echo -n "$temp_path"
  else
    echo -n "$destination_path"
  fi
}

contents="# $title"
ext="md"
slug=$(echo "$title" | ~/.bin/f_slug)
today=$(date +%Y-%m-%d)
dated_slug="$today-$slug"
readme_path=$(make_file "README.${ext}" "$dated_slug" "$contents")
make_file "README.${ext}" "$dated_slug/archive" "$contents Archive" >/dev/null
mkdir "$dated_slug/archive/projects"
echo -n "[$title]($dir/$readme_path)"
