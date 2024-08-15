#!/usr/bin/env bash

# Remove `e` to allow failing if a keyboard is missing
set -uo pipefail

sftp aresdev:Developer/Projects/Hardware/qmk_firmware/.build/ergodox_ez_base_robenkleene_macos2.hex .
sftp aresdev:Developer/Projects/Hardware/qmk_firmware/.build/moonlander_robenkleene_macos.bin .
sftp aresdev:Developer/Projects/Hardware/qmk_firmware/.build/zsa_voyager_robenkleene_macos.bin .
