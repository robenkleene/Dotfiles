#!/usr/bin/env zsh

if [[ ! -d "$1" ]]; then
  echo "Usage: git-sync-clone <root directory> [repos file] [run]"
  exit 1
fi

dry_run=true
if [[ "$3" == "run" ]]; then
  dry_run=false
else
  echo "Dry Run\n"
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
done < "${2:-/dev/stdin}"

cd "$1" || exit 1

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
