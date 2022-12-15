#!/usr/bin/env bash

set -eo pipefail

edit="false"
path="false"
directory="false"
while getopts ":pdeh" option; do
  case "$option" in
    d)
      directory="true"
      ;;
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
  command="${MD_EDITOR_COMMAND:=vim}"
elif [[ "$path" == "true" || "$directory" == "true" ]]; then
  command="echo"
else
  command="${MD_CAT_COMMAND:=cat}"
fi

cd ~/Documentation/ || return 1
cmd="fd --type f --follow -g \"*.md\""

if [[ "$directory" == "true" ]]; then
  cmd="fd --follow --type d"
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
