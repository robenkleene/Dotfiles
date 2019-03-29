#!/usr/bin/env bash

set -e

pulls="false"
while getopts ":f:ph" option; do
  case "$option" in
    f)
      file="$OPTARG"
      ;;
    p)
      pulls="true"
      ;;
    h)
      echo "Usage: command [-hp] [-f <file>]"
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

if [[ -f "$file" ]]; then
  file_path="$file"
  dir_path=$(dirname "$file")
elif [[ -d "$file" ]]; then
  dir_path="$file"
else
  echo "$file is not a valid file or dir_path" >&2
  exit 1
fi

cd "$dir_path"

remote=$(git config --get remote.origin.url | tr -d '\n')

if [[ -n "$file_path" ]]; then
  file_subpath=$(git ls-tree --full-name --name-only HEAD "$file_path")
  commit=$(git rev-parse HEAD)
else
  branch=$(git rev-parse --abbrev-ref HEAD)
fi

final_url=''
if [[ $remote =~ (https://|git@)github.com[/:](.*) ]]; then
  remote_subpath="${BASH_REMATCH[2]}"
  remote_subpath=${remote_subpath%.git}
  repo_url="github.com/$remote_subpath"
  if [[ "$pulls" == "true" ]]; then
    final_url=$repo_url/pulls
  elif [[ -z "$file_subpath" ]]; then
    final_url=$repo_url/tree/$branch
  else
    final_url="$repo_url/blob/$commit/$file_subpath"
  fi
elif [[ $remote =~ (https://|git@)bitbucket.(com|org)[/:](.*) ]]; then
  remote_subpath="${BASH_REMATCH[3]}"
  remote_subpath=${remote_subpath%.git}
  repo_url="bitbucket.org/$remote_subpath"
  if [[ -z "$file_subpath" ]]; then
    final_url=$repo_url/branch/$branch
  else
    final_url="$repo_url/src/$commit/$file_subpath"
  fi
elif [[ $remote =~ (https://|git@)([^/:]*)[/:](.*) ]]; then
  # Otherwise, assume GitHub style, which will make enterprise Github work.
  host="${BASH_REMATCH[2]}"
  remote_subpath="${BASH_REMATCH[3]}"
  remote_subpath=${remote_subpath%.git}
  repo_url="$host/$remote_subpath"
  if [[ -z "$file_subpath" ]]; then
    final_url=$repo_url/tree/$branch
  else
    final_url="$repo_url/blob/$commit/$file_subpath"
  fi
fi

encoded_url=$(~/.bin/url_encode "$final_url")
echo "https://$encoded_url"
