#!/usr/bin/env bash

handle-github() {
  echo "git@github.com:$1.git"
}

while read line; do
  old_IFS=$IFS
  IFS=" "
  read -ra subpath <<< "$line"
  type=${subpath[0]}
  subpath=${subpath[1]}
  IFS=${old_IFS}
  # Strip quotes
  subpath="${subpath%\"}"
  subpath="${subpath#\"}"

  case "$type" in
    "github")
      handle-github $subpath
      ;;
    *)
      echo "$type isn't supported"
      exit 1
      ;;
  esac
done < /dev/stdin
