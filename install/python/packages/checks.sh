check_paths() {
  local destination
  destination=$(python3 -m site --user-base)
  if [[ "$(uname)" = "Darwin" ]]; then
    if ! test -e "$destination"; then
      echo "Warning: $destination doesn't exist, this might mean a new version of Python is being used" >&2
    fi
    local parent
    parent="${destination%/*}"
    if test $(ls -1 "$parent" | wc -l) -gt 1; then
      echo "Warning: $parent contains multiple Python versions, this might mean a new version of Python is being used" >&2
    fi
  elif [[ "$(uname)" = "Linux" ]]; then
    if ! test -e "$destination"; then
      echo "Warning: $destination doesn't exist" >&2
    fi
    local parent
    parent=$destination/lib
    if test $(ls -1 "$parent" | wc -l) -gt 1; then
      echo "Warning: $parent contains multiple Python versions, this might mean a new version of Python is being used" >&2
    fi
  fi
}
