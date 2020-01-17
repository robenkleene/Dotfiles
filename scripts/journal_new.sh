#!/usr/bin/env bash

set -e

filename=$(~/.bin/journal_new_make_default)
eval "$EDITOR $filename"
