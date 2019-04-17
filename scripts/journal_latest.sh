#!/usr/bin/env bash

set -e

filename=$(~/.bin/journal_newest ~/Dropbox/Text/Journal)
eval "$EDITOR $filename"
