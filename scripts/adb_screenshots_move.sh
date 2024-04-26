#!/usr/bin/env bash

set -euo pipefail

# The `-f` option suppresses the error if there are no files to delete
adb pull /sdcard/Oculus/Screenshots/ && adb shell 'cd /sdcard/Oculus/Screenshots && rm -f *.jpg' || true
adb pull /sdcard/Oculus/VideoShots/ && adb shell 'cd /sdcard/Oculus/VideoShots && rm -f *.mp4' || true
