#!/usr/bin/env bash

set -e

filename=$(~/.bin/journal_new_make ~/Dropbox/Text/Journal)
eval "$EDITOR $filename"
