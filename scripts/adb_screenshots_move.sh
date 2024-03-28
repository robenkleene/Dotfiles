#!/usr/bin/env bash

set -euo pipefail

adb pull /sdcard/Oculus/Screenshots/
adb pull /sdcard/Oculus/VideoShots/
# The `-f` option suppresses the error if there are no files to delete
adb shell 'cd /sdcard/Oculus/Screenshots && rm -f *.jpg'
adb shell 'cd /sdcard/Oculus/VideoShots && rm -f *.mp4'
