#!/usr/bin/env bash

firefox="false"
technology="false"
while getopts ":fth" option; do
  case "$option" in
    f)
      firefox="true"
      ;;
    t)
      technology="true"
      ;;
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

if [[ "$firefox" == "false" && "$technology" == "false" ]]; then
  if [[ "$BROWSER_FLAG" = "-t" ]]; then
    technology="true"
  elif [[ "$BROWSER_FLAG" = "-f" ]]; then
    firefox="true"
  fi
fi

if [[ "$firefox" == "true" ]]; then
  browser_arg="-a Firefox"
elif [[ "$technology" == "true" ]]; then
  # Couldn't figure out how to encode this into a variable with spaces
  # browser_arg="-a \"Safari Technology Preview\""
  open -a "Safari" "$(~/.bin/urls -b)"
  exit 0
fi

if [[ -n "$1" ]]; then
  open "$browser_arg" "$(~/.bin/urls -b)"
else
  open "$(~/.bin/urls -b)"
fi
