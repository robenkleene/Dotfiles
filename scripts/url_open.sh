#!/bin/sh

firefox="false"
while getopts ":fh" option; do
  case "$option" in
    f)
      firefox="true"
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

if [[ "$firefox" == "true" ]]; then
  browser_arg="-a Firefox"
fi

open $browser_arg "$(urls -b)"
