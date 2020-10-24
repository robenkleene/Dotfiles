#!/usr/bin/env bash

set -e

cd /Applications/Houdini/Current/Frameworks/Houdini.framework/Versions/Current/Resources/
source ./houdini_setup >/dev/null
cd - >/dev/null
/Applications/Houdini/Current/Frameworks/Houdini.framework/Versions/Current/Resources/bin/houdini -apprentice "$@"
