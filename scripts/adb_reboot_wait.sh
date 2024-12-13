#!/usr/bin/env bash

set -euo pipefail

while ! adb devices | grep device$ -q
do
  echo "Waiting for reboot"
  sleep 1
done
