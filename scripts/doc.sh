#!/usr/bin/env bash

set -eo pipefail

edit="false"
path="false"
while getopts ":peh" option; do
  case "$option" in
    p)
      path="true"
      ;;
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
elif [[ "$path" == "true" ]]; then
  command="echo"
else
  command="${MD_CAT_COMMAND:=cat}"
fi

cd ~/Documentation/ || return 1
cmd="fd --type f --follow -g \"*.md\""
if [[ "$path" == "true" ]]; then
  cmd="fd --follow"
fi

result="$(eval "$cmd" | fzf)"
if [[ -z "$result" ]]; then
  exit
fi

parameter=$(printf '%q' "$PWD/$result")
if [[ -e "$parameter" ]]; then
  final_cmd="$command $parameter"
  eval "$final_cmd"
fi
