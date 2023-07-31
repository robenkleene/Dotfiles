#!/usr/bin/env bash

# Use default browser
export BROWSER=

~/.bin/git_web_link -f . "$@" | ~/.bin/f_a_to_urls_open
