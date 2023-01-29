#!/usr/bin/env bash

# Use default browser
export BROWSER=

~/.bin/git_web_link -f . "$@" | ~/.bin/url_open
