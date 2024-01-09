#!/usr/bin/env bash

# Use default browser
export BROWSER=

~/.bin/git_web_link -f . "$@" | ~/.bin/p_txt_to_url_open
