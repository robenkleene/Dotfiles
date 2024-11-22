#!/usr/bin/env bash

# Remove `e` to allow failing if a keyboard is missing
set -uo pipefail

if [[ "$1" = "moonlander" ]]; then
  sftp aresdev:Developer/Projects/Hardware/qmk_firmware/.build/moonlander_robenkleene_macos.bin .
  exit 0
fi
if [[ "$1" = "ergodox" ]]; then
  sftp aresdev:Developer/Projects/Hardware/qmk_firmware/.build/ergodox_ez_base_robenkleene_macos2.hex .
  exit 0
fi
if [[ "$1" = "voyager" ]]; then
  sftp aresdev:Developer/Projects/Hardware/qmk_firmware/.build/zsa_voyager_robenkleene_macos.bin .
  exit 0
fi
if [[ "$1" = "lily" ]]; then
  sftp aresdev:Developer/Projects/Hardware/qmk_firmware/.build/keebio_iris_rev8_robenkleene_macos.elf .
  exit 0
fi

sftp aresdev:Developer/Projects/Hardware/qmk_firmware/.build/ergodox_ez_base_robenkleene_macos2.hex .
sftp aresdev:Developer/Projects/Hardware/qmk_firmware/.build/moonlander_robenkleene_macos.bin .
sftp aresdev:Developer/Projects/Hardware/qmk_firmware/.build/zsa_voyager_robenkleene_macos.bin .
sftp aresdev:Developer/Projects/Hardware/qmk_firmware/.build/keebio_iris_rev8_robenkleene_macos.elf .
