#!/usr/bin/env bash


FLTR_DIRECTORY="~/Documents/Shell/"
FLTR_FILENAME="filter.sh"
FLTR_PATH="${FLTR_PATH}${FLTR_FILENAME}"

if [[ ! -f "$FLTR_PATH" ]]; then
  mkdir -p "$FLTR_DIRECTORY"
  cat "#!/usr/bin/env bash\n\ncat" > "$FLTR_PATH"
fi

eval "$FLTR_PATH"
