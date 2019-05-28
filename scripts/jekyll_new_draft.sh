#!/usr/bin/env bash

set -e

link=false
pipe=false
while getopts ":t:lf:hi" option; do
  case "$option" in
    i)
      pipe=true
      ;;
    t)
      title="$OPTARG"
      ;;
    f)
      file="$OPTARG"
      ;;
    l)
      link=true
      ;;
    h)
      echo "Usage: jekyll_new_draft [-l] -a <file>]"
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

if [[ "$pipe" == "true" ]]; then
  text=$(cat)
fi

if [[ -n "$file" ]]; then
  if [[ -f "$file" ]]; then
    text=$(cat "$file")
  else
    echo "Error: $file is not a file" >&2
    exit 1
  fi
fi

if [[ -z "$title" ]]; then
  if [[ -n "$text" ]]; then
    title=$(echo "${text}" | sed -nE '1 s/# *(.*)/\1/p' | tr -d '\n')
    if [[ -z "$title" ]]; then
      echo "Missing title with the -t option" >&2
      exit 1
    else
      text=$(echo "${text}" | sed 1d)
    fi
  fi
fi

slug=$(echo "$title" | ~/.bin/slug)

drafts_directory=~/Development/Projects/Web/robenkleene.github.io/_drafts
if [[ ! -d "$drafts_directory" ]]; then
  echo "$drafts_directory is not a directory" >&2
  exit 1
fi

today=$(date +%Y-%m-%d)
post_path=$(mktemp "$drafts_directory/$today-XXXX")

[[ "$link" = true ]] && kind="link" || kind="post"

content="---
layout: $kind
title: \"$title\"
categories: 
---
$text
"

echo "$content" >"$post_path"

destination_post_path="${drafts_directory}/${today}-${slug}.md"
mv -n "$post_path" "$destination_post_path"
if [[ -f "$post_path" ]]; then
  echo -n "$post_path"
else
  echo -n "$destination_post_path"
fi
