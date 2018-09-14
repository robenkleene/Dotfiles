#!/usr/bin/env bash


FLTR_DIRECTORY="$HOME/Documents/Shell/"
FLTR_FILENAME="filter.sh"
FLTR_PATH="${FLTR_DIRECTORY}${FLTR_FILENAME}"

if [[ ! -f "$FLTR_PATH" ]]; then
  mkdir -p "$FLTR_DIRECTORY"
  echo -e -n "#!/usr/bin/env bash\n\ncat" > "$FLTR_PATH"
fi

if [[ ! -x "$FLTR_PATH" ]]; then
  chmod a+x "$FLTR_PATH"
fi

if [[ "$1" == "-c" ]]; then
  # `-c` to only create the file if it's missing
  exit 0
fi

$FLTR_PATH
