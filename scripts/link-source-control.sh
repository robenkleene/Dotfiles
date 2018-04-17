#!/usr/bin/env bash


if [[ -f "$1" ]]; then
  file_path="$1"
  dir_path=$(dirname "$1")
elif [[ -d "$1" ]]; then
  dir_path="$1"
else
  echo "$1 is not a valid file or dir_path" >&2
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
  if [[ -z "$file_subpath" ]]; then
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

encoded_url=$(~/.bin/url-encode "$final_url")
echo "https://$encoded_url"
