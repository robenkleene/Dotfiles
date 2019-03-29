#!/usr/bin/env bash

if [[ -z "$1" ]]; then
  arg="$BROWSER_FLAG"
else
  arg="$1"
fi
~/.bin/link_source_control -f . | ~/.bin/url_open "$arg"
