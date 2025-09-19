#!/usr/bin/env bash

set -euo pipefail

if [[ "${1:-}" = "help" ]]; then
  echo "- slugpm: With standard input, creates a slug from the first line of standard input, and creates a directory at project/<slug>"
  echo "- slugpm <title>: Without standard input, creates a slug from <title>, and creates a directory at project/<slug>"
  echo "- slugpm archive <filename> -: Appends standard input to the end of a file named <filename> in archive/<filename> relative to filename"
  echo "- slugpm archive <filename>: Moves <filename> to archive/<filename> relative to <filename>"
  echo "- slugpm archive <dirname>: Moves <dirname> to ../archive/<dirname> relative to <dirname>"
  echo "- slugpm name <dirname>: Print name of project excluding date"
  exit 0
fi

safe_mv() {
  # `mv -f -- "$src" "$tmp" || return 1` will fail if `$src` is a directory,
  # because `mv -f` won't let a directory overwite a file, so commenting this
  # out for now, just using `mv -n` and failing is probably fine for now.
  #
  # local src="$1"
  # local dst="$2"
  # local tmp="$(mktemp "${dst}.XXXXXX")" || return 1

  # mv -f -- "$src" "$tmp" || return 1
  # mv -n "$tmp" "$src"
  mv -n "$1" "$2"
}

if [[ "${1:-}" = "name" ]]; then
  args="${@:2}"
  if [[ "$args" == '.' ]]; then
    args="$PWD"
  fi
  filename=${args##*/}
  filename_no_ext=${filename%.*}
  echo $filename_no_ext | sed 's/^[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}//' | tr "-" " " | ~/.bin/f_titlecase | tr -d '\n'
  exit 0
fi

if [[ "${1:-}" = "archive" ]]; then

  # `archive <path> -`: Three args
  if [[ "${@: -1}" = "-" && $# -eq 3 ]]; then
    # Process standard input
    file_path="$2"
    file_path=${file_path%/}
    filename=${file_path##*/}
    if [[ ! -n "${archived_stdin:-}" ]]; then
      text="$(</dev/stdin)"
      archived_stdin=1
      if [[ -n "$text" ]]; then
        dest_file="archive/$filename"
        if [[ -f "$dest_file" ]]; then
          echo "$text" >>"$dest_file"
        else
          echo "Error: $dest_file is not a file" >&2
          exit 1
        fi
      fi
      # Don't try to also move files if we parsed standard input. E.g.,
      # appending to a file with the same name in archive, and then trying to
      # copy over that file doesn't make sense.
      exit 0
    fi
  fi

  # Args excluding the word "archive"
  for file_path in "${@:2}"; do

    # Remove leading and trailing slash and leading period
    # Can't remove leading dot because that will break if already in the
    # `file_path` so the entire path is `.`
    # file_path=${file_path#\.}
    file_path=${file_path%/}
    file_dir=${file_path%/*}
    filename=${file_path##*/}

    if [[ -d "$file_path/../../projects" ]]; then
      # If the a parent directory is `projects` treat as a project, and archive
      # to projects archive
      dest_dir="$file_path/../../archive/projects"

      if [[ ! -d "$dest_dir" ]]; then
        echo "Error: $dest_dir does not exist" >&2
        exit 1
      fi

      # Convert an absolute path which helps in the case where current directory
      # is just `.`
      src_dir=$(cd "$file_path"; pwd)
      safe_mv "$src_dir" "$dest_dir/$filename"
    else
      # If the a parent directory is NOT `projects`, don't treat as a project,
      # and archive to relative archive directory
      dest_dir="archive"
      if [[ ! -d "$dest_dir" ]]; then
        echo "Error: $dest_dir does not exist" >&2
        exit 1
      fi
      safe_mv "$file_path" "$dest_dir/$filename"
    fi
  done
  exit 0
fi

title="$@"
if [[ -z "${title:-}" ]]; then
  text="$(</dev/stdin)"
  while read -r line; do
    if [[ -n "${title:-}" ]]; then
      echo "Error: Only use line at a time" >&2
      exit 1
    fi
    title="$line"
    print_link=1
  done <<< "$text"
fi

if [[ -z "$title" ]]; then
  echo "Error: No valid title found" >&2
  exit 1
fi

project_dir="projects"

# Remove leading and trailing slash and leading period
project_dir=${project_dir#\.}
project_dir=${project_dir#/}
project_dir=${project_dir%/}
if [[ -e "$project_dir" ]] && [[ ! -d "$project_dir" ]]; then
  echo "Error: $project_dir exists and is not a dir" >&2
  exit 1
elif [[ ! -e "$project_dir" ]]; then
  echo "Error: $project_dir does not exist" >&2
  exit 1
fi

slug=$(echo "$title" | ~/.bin/f_slug)
today=$(date +%Y-%m-%d)
dated_slug="$today-$slug"

dst="$project_dir/$dated_slug"
tmp="$(mktemp -d "$project_dir/$dated_slug.XXXXXX")"
mkdir -p "$tmp/archive"

mv -n "$tmp" "$dst"

if [[ -n "${print_link:-}" ]]; then
  if [[ ! -e "$tmp" ]]; then
    result="$dst"
  else
    result="$tmp"
  fi
  echo -n "[$title]($result)"
fi
