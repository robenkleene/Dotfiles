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

cmd="fd --type f --follow -g \"*.md\""

if [[ "$edit" == "true" ]]; then
  # With edit, allow directories
  cmd="fd --follow --exclude \"*.{png,jpg}\""
  command="${MD_EDITOR_COMMAND:=vim}"
elif [[ "$path" == "true" || "$directory" == "true" ]]; then
  command="echo"
else
  command="${MD_CAT_COMMAND:=cat}"
fi

if [[ "$directory" == "true" ]]; then
  cmd="fd --follow --type d"
fi

cd ~/Documentation/ || return 1

set +e
result="$(eval "$cmd" | fzf --preview 'bat -n --color=always {}' --bind 'ctrl-f:preview-page-down,ctrl-b:preview-page-up')"
set -e
if [[ -z "$result" ]]; then
  exit
fi

parameter="$PWD/$result"
if [[ -e $parameter ]]; then
  parameter=$(printf '%q' "$PWD/$result")
  final_cmd="$command $parameter"
  eval "$final_cmd"
fi
