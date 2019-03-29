#!/usr/bin/env bash

# if [[ -z "$1" ]]; then
browser_arg="$BROWSER_FLAG"
# else
#   browser_arg="$1"
# fi
~/.bin/link_source_control -f . "$@" | ~/.bin/url_open "$browser_arg"
