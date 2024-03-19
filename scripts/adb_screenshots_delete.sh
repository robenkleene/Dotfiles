#!/usr/bin/env bash

set -euo pipefail

adb shell cd /sdcard/Oculus/Screenshots && rm *.jpg
adb shell cd /sdcard/Oculus/VideoShots && rm *.mp4
