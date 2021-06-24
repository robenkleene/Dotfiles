#!/usr/bin/env bash

set -euo pipefail

while getopts ":C:h" option; do
  case "$option" in
    C)
      git_parameter=" -C $OPTARG"
      ;;
    h)
      echo "Usage: command [-hf] [-p <file_path>]"
      exit 0
      ;;
    :)
      echo "Option -OPTARG requires an argument" >&2
      exit 1
      ;;
    \?)
      echo "Invalid option: -OPTARG" >&2
      exit 1
      ;;
  esac
done

exec git${git_parameter-} rev-parse --show-toplevel
