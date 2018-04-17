#!/usr/bin/env bash

if [ -z "$BUILD_COMMAND" ]; then
  echo '$BUILD_COMMAND is not set'
  exit 1
fi

eval $BUILD_COMMAND
