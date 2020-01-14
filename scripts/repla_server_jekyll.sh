#!/usr/bin/env bash

set -e

arg=$*
repla server "bundle exec jekyll serve --watch --drafts $arg"
