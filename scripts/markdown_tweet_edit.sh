#!/usr/bin/env bash

set -e

file=$(~/.bin/markdown_tweet)
eval "$EDITOR \"$file\""
