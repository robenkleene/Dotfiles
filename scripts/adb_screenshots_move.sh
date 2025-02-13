#!/usr/bin/env bash

set -euo pipefail

# The `-f` option suppresses the error if there are no files to delete
adb shell 'cd /sdcard/Oculus/Screenshots/ || exit 0; ls | sed s#^#$PWD/#' | tr -s "\r\n" "\0" | xargs -0 -n1 adb pull && adb shell 'rm -f /sdcard/Oculus/Screenshots/*.{jpg,png}' || true
adb shell 'cd /sdcard/Oculus/VideoShots/ || exit 0; ls | sed s#^#$PWD/#' | tr -s "\r\n" "\0" | xargs -0 -n1 adb pull && adb shell 'rm -f /sdcard/Oculus/VideoShots/*.mp4' || true
adb shell 'cd /sdcard/Oculus/PanelShots/ || exit 0; ls | sed s#^#$PWD/#' | tr -s "\r\n" "\0" | xargs -0 -n1 adb pull && adb shell 'rm -f /sdcard/Oculus/PanelShorts/*.{jpg,png}' || true
