#!/usr/bin/env bash

set -euo pipefail

if [[ "$1" = "archive" ]]; then
  exec ~/.bin/slugpm_archive "$@"
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

directory="projects"

if [[ -n "$directory" ]]; then
  # Remove leading and trailing slash and leading period
  directory=${directory#\.}
  directory=${directory#/}
  directory=${directory%/}
  if [[ -e "$directory" ]] && [[ ! -d "$directory" ]]; then
    echo "$directory is not a directory" >&2
    exit 1
  else
    mkdir -p "$directory"
  fi
  cd "$directory"
  # Add a trailing slash for output later
  directory="$directory/"
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
echo -n "[$title]($directory$readme_path)"
