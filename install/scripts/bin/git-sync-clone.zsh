#!/usr/bin/env zsh

set -e

force="false"
while getopts ":p:s:fh" option; do
  case "$option" in
    p)
      file_path="$OPTARG"
      ;;
    s)
      source_file="$OPTARG"
      ;;
    f)
      force="true"
      ;;
    h)
      usage
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

usage() {
  echo "Usage: git_sync_clone -p <root directory> -s [repos file] [-f]"
}

if [[ ! -d "$file_path" ]]; then
  echo "Missing or invalid root directory $file_path"
  usage
  exit 1
fi

# Remove this check to allow process substitution
# if [[ ! -f "$source_file" ]]; then
#   echo "Missing or invalid repos file"
#   usage
#   exit 1
# fi

dry_run=true
if [[ "$force" == "true" ]]; then
  dry_run=false
fi

typeset -A repos

while read line; do
  old_IFS=$IFS
  IFS=" "
  read -r remote dir <<< "$line"
  IFS=${old_IFS}
  dir="${dir%\"}"
  dir="${dir#\"}"
  repos+=( $dir $remote )
done < "${source_file:-/dev/stdin}"

cd "$file_path" || exit 1

for directory in "${(@k)repos}"; do
  remote="$repos[$directory]"
  # Test it's a directory
  if [[ -d "$directory" ]]; then
    current=$(cd "$directory"; git ls-remote --get-url | tr -d '\n')
    # Test that it can get the remote
    if (($? > 0)); then
      echo "ERROR: Failed to get the git remote URL at $directory"
    else
      # Test that the remote is accurate
      if [[ "$current" != "$remote" ]]; then
        echo "current = $current"
        echo "remote = $remote"
        echo "WARNING: The remote does not match $remote in $directory"
        echo "Replacing $current with $remote"
        if ! $dry_run; then
          $(cd "$directory"; git remote rm origin)
          if (($? > 0)); then
            echo "ERROR: Failed remove $current"
          else
            $(cd "$directory"; git remote add origin $remote)
            if (($? > 0)); then
              echo "ERROR: Failed to add $remote"
            fi
          fi
        fi
      else
        echo "The remote is correct for $directory"
      fi
    fi
  else
    echo "Cloning $remote into $directory"
    exitstatus=0
    if ! $dry_run; then
      git clone $remote "$directory"
      if (($? > 0)); then
        echo "ERROR: Failed cloning $remote into $directory"
      fi
    fi
  fi
done
