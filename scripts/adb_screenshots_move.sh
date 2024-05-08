#!/usr/bin/env bash

set -euo pipefail

# The `-f` option suppresses the error if there are no files to delete
adb shell 'ls /sdcard/Oculus/Screenshots/' | tr -s "\r\n" "\0" | xargs -0 -n1 adb pull && adb shell 'rm -f /sdcard/Oculus/Screenshots/*.{jpg,png}' || true
adb shell 'ls /sdcard/Oculus/VideoShots/' | tr -s "\r\n" "\0" | xargs -0 -n1 adb pull && adb shell 'rm -f /sdcard/Oculus/VideoShots/*.mp4' || true
