#!/usr/bin/env bash

# set -e

emacs=false
while getopts ":eh" option; do
  case "$option" in
    e)
      emacs=true
      ;;
    h)
      echo "Usage: command [-hb] [-a <file>]"
      exit 0
      ;;
    :)
      echo "Option -$OPTARG requires an argument" >&2
      exit 1
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

process_dir() {
  if [[ -f "Gemfile" ]]; then
    if [[ "$emacs" == "true" ]]; then
      ripper-tags --emacs -R
    else
      ripper-tags -R
    fi
    return 0
  elif [[ -d ".git" ]]; then
    if [[ "$emacs" == "true" ]]; then
      ctags -e
    else
      ctags
    fi
    return 0
  fi

  return 1
}

while [[ $PWD != / ]] ; do
    process_dir
    status=$?
    if [[ $status -eq 0 ]]; then
      break
    fi
    cd ..
done

if [[ $PWD == / ]]; then
  echo "No root directory found" >&2
fi
