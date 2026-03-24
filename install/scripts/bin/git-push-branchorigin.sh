#!/usr/bin/env bash

set -euo pipefail

git_parameter=""
branch=""
while getopts ":C:h" option; do
  case "$option" in
    C)
      git_parameter=" -C $OPTARG"
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

git$git_parameter push --set-upstream origin "$(git$git_parameter rev-parse --abbrev-ref HEAD)"
