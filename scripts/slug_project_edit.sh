#!/usr/bin/env bash

file=$(~/.bin/slug_project -t "$1")
$EDITOR "$file"
