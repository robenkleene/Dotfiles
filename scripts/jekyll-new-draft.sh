#!/usr/bin/env bash

set -e

if [ "$#" -ne 1 ]; then
    echo "Wrong number of arguments" >&2
    exit 1
fi

# Make all lowercase and replace hyphens with spaces
title=$1
slug=$(echo "$1" | tr -dc '[:alnum:]\r\n.\-/ ' | tr -s ' ' | tr '[A-Z]' '[a-z]' | tr ' ' '-')

drafts_directory=~/Development/Projects/Web/robenkleene.github.io/_drafts
if [[ ! -d "$drafts_directory" ]]; then
  echo "$drafts_directory is not a directory" >&2
  exit 1
fi

today=$(date +%Y-%m-%d)
post_path=$(mktemp "$drafts_directory/$today-XXXX")

content="---
layout: post
title: \"$title\"
categories: 
---
"

echo "$content" > "$post_path"
cat >> "$post_path"

destination_post_path="$drafts_directory/$today-$slug.md"
mv -n "$post_path" "$destination_post_path"
if [[ -f "$post_path" ]]; then
  # The move failed
  echo -n $post_path
else
  # The move succeeded
  echo -n $destination_post_path
fi
