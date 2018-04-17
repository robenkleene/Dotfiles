#!/usr/bin/env bash

git diff $(git show $1 | grep -m 1 "^Merge\:" | cut -d":" -f 2 | sed 's/^ //' | awk '{ print $2 " " $1 }' | sed 's/ /.../')
