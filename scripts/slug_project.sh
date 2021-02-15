#!/usr/bin/env bash

set -e

link="false"
while getopts ":t:d:lh" option; do
  case "$option" in
    t)
      title="$OPTARG"
      ;;
    d)
      directory="$OPTARG"
      ;;
    l)
      link="true"
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

if [[ -z "$title" ]]; then
  text=$(cat)
  while read -r line; do
    if [[ -n "$title" && -n "$line" ]]; then
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

if [[ -z "$directory" ]]; then
  directory="projects"
fi

if [[ -n "$directory" ]]; then
  # Remove leading and trailing slash and leading period
  directory=${directory#\.}
  directory=${directory#/}
  directory=${directory%/}
  if [[ ! -d "$directory" ]]; then
    echo "$directory is not a directory" >&2
    exit 1
  fi
  cd "$directory"
  # Add a trailing slash for output later
  directory="$directory/"
fi

make_file() {
  local name=$1
  local directory=$2
  local contents=$3
  mkdir -p "$directory"
  local temp_path
  temp_path=$(mktemp "$directory/$name-XXXX")
  echo "$contents" >"$temp_path"
  local destination_path="$directory/$name"
  mv -n "$temp_path" "$destination_path"
  if [[ -f "$temp_path" ]]; then
    echo -n "$temp_path"
  else
    echo -n "$destination_path"
  fi
}

contents="# $title"
slug=$(echo "$title" | ~/.bin/slug)
today=$(date +%Y-%m-%d)
dated_slug="$today-$slug"
readme_path=$(make_file "README.md" "$dated_slug" "$contents")
make_file "README.md" "$dated_slug/archive" "$contents Archive" >/dev/null
if [[ "$link" == "true" ]]; then
  echo -n "[$title]($directory$readme_path)"
else
  echo -n "$directory$readme_path"
fi
