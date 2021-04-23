#!/usr/bin/env bash

use_https="false"
while getopts ":Hsh" option; do
  case "$option" in
    H)
      use_https="true"
      ;;
    s)
      ;;
    h)
      echo "Usage: command [-hf] [-p <file_path>]"
      exit 0
      ;;
    :)
      echo "Option -OPTARG requires an argument" >&2
      exit 1
      ;;
    \?)
      echo "Invalid option: -OPTARG" >&2
      exit 1
      ;;
  esac
done

if [[ "$use_https" == "true" ]]; then
  sed 's/git@/https\:\/\//g' | perl -pe 's|(https\://.*?):|\1/|'
else
  sed 's/^https\:\/\//git@/' | perl -pe 's|(git@.*?)/|\1:|'
fi
