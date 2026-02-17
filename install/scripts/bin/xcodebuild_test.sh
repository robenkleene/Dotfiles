#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "Test requires specifying a scheme"
  xcodebuild -list
  exit 1
fi

xcodebuild test -alltargets -configuration Debug -scheme $@
