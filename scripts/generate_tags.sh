#!/usr/bin/env bash

# set -e

FILENAME="tags"
EMACS_FILENAME="TAGS"

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

correct_filenames() {
  src="$1"
  dst="$2"
  # Can't test filenames case-sensitive this way
  # if [[ ! -f $dst ]]; then
  if [[ -f $src ]]; then
    mv $src $dst
  else
    echo "Error tags file missing" >&2
    exit 1
  fi
  # fi
}

process_dir() {
  if [[ -f "Gemfile" ]]; then
    if [[ "$emacs" == "true" ]]; then
      ripper-tags --emacs -R
      correct_filenames $FILENAME $EMACS_FILENAME
    else
      ripper-tags -R
      correct_filenames $EMACS_FILENAME $FILENAME
    fi
    return 0
  elif [[ -d ".git" ]]; then
    if [[ "$emacs" == "true" ]]; then
      ctags -e
      correct_filenames $FILENAME $EMACS_FILENAME
    else
      ctags
      correct_filenames $EMACS_FILENAME $FILENAME
    fi
    return 0
  fi

  return 1
}

while [[ $PWD != / ]]; do
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
