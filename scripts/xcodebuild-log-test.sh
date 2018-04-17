#!/bin/bash

# If you can figure out how to store and retrieve an empty string with shell
# quote escape rules, then this could be combined into one command.
if [ -n "$1" ]; then
  if [ ! -f "$1" ]; then
    echo "$1 does not exist" 
    exit 0
  fi
  sed -e 's/^/		/' -e 's/^		Test Suite/Test Suite/' -e 's/^		Test Case/	Test Case/' -e 's/^			 Executed/Executed/' -i '' $1
else
  sed -e 's/^/		/' -e 's/^		Test Suite/Test Suite/' -e 's/^		Test Case/	Test Case/' -e 's/^			 Executed/Executed/'
fi
