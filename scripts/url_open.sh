#!/usr/bin/env bash

while getopts ":b:h" option; do
  case "$option" in
    b)
      browser_flag="$OPTARG"
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

if [[ -z "$browser_flag" ]]; then
  if [[ -n "$BROWSER" && "$BROWSER" != "none" ]]; then
    browser_arg="-a$BROWSER"
  fi
else
  browser_arg="-a$browser_flag"
fi

if [[ -z "$browser_arg" ]]; then
  open "$(~/.bin/urls -b)"
else
  open "$browser_arg" "$(~/.bin/urls -b)"
fi
