#!/usr/bin/env bash

set -eo pipefail

edit="false"
while getopts ":eh" option; do
  case "$option" in
    e)
      edit="true"
      ;;
    h)
      echo "Usage: command [-e]"
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

if [[ "$edit" == "true" ]]; then
  command="${EDITOR:=vim}"
else
  command="${MD_CAT_COMMAND:=cat}"
fi

cd ~/Developer/Snippets/ || return 1
cmd="fd --strip-cwd-prefix --type f --follow"

set +e
result="$(eval "$cmd" | ~/.bin/fzf_file)"
set -e

if [[ -n "$result" ]]; then
  parameter=$(printf '%q' "$PWD/$result")
  ~/.bin/safecopy < "$parameter"
  final_cmd="$command $parameter"
  eval "$final_cmd"
fi
