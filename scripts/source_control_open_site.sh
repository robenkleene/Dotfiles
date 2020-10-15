#!/usr/bin/env bash

# Use default browser
export BROWSER=

~/.bin/link_source_control -f . "$@" | ~/.bin/url_open
