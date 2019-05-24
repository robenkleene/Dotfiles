#!/bin/bash

branch=$(git rev-parse --abbrev-ref HEAD)
if [[ "$branch" != "master" ]]; then
  echo "Only run this script from branch master" >&2
  exit 1;
fi

while getopts ":h" option; do
  case "$option" in
    h)
      echo "Usage: command [-hb] [-a <file>]"
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
shift $((OPTIND - 1))


get_version_tags() {
  pattern="^([0-9]+\.[0-9]+\.[0-9]+)\$"
  for tag in $(git tag); do
    if [[ "$tag" =~ $pattern ]]; then
      echo "${BASH_REMATCH[1]}"
    fi
  done
}

get_sorted_version_tags() {
  version_tags=$(get_version_tags)
  if [[ -z "$version_tags" ]]; then
    return
  fi
  echo "$version_tags" | tr '.' ' ' | sort -nr -k 1 -k 2 -k 3 | tr ' ' '.'
}

get_latest_tags() {
  count="$1"
  version_tags=$(get_sorted_version_tags)
  if [ -z "$version_tags" ]; then
    return
  fi
  echo "$version_tags" | head -${count}
}


get_next_version() {
  latest_tag=$4
  if [[ $1 -gt 0 ]]; then
    format="\"%d.%d.%d\", \$1+a, 0, 0"
  elif [[ $2 -gt 0 ]]; then
    format="\"%d.%d.%d\", \$1+a, \$2+b, 0"
  else
    format="\"%d.%d.%d\", \$1+a, \$2+b, \$3+c"
  fi
  echo "$latest_tag" | awk -F. -v a="$1" -v b="$2" -v c="$3" \
    "{printf($format)}"
    # '{printf("%d.%d.%d", $1+a, $2+b , $3+c)}'
}

bump() {
  latest_tag=$4
  next_version=$(get_next_version "$1" "$2" "$3" "$latest_tag")
  latest_commit=$(git rev-parse "${latest_tag}" 2>/dev/null)
  head_commit=$(git rev-parse HEAD)
  if [ "$latest_commit" = "$head_commit" ]; then
    echo "Current commit already tagged as $latest_tag"
    exit 1
  else
    if [[ "$force" == "true" ]]; then
      git tag "$next_version"
    else
      echo "Dry run"
    fi
    echo "$next_version"
  fi
}

force="false"
if [[ "$2" = "-f" ]]; then
  force="true"
fi

latest_tag=$(get_latest_tags 1)
if [[ -z "$latest_tag" ]]; then
  echo "Error: No tags found" >&2
  exit 1
fi

case $1 in
  major)
    bump 1 0 0 "$latest_tag"
    ;;
  minor)
    bump 0 1 0 "$latest_tag"
    ;;
  patch)
    bump 0 0 1 "$latest_tag"
    ;;
  *)
    echo "$latest_tag"
    ;;
esac
