function safe_symlink() {
  source="$1"
  destination="$2"
  if [ ! -e "$destination" ]; then
    ln -s "$source" "$destination"
  elif [ ! -L "$destination" ]; then
    if [ "$destination" != "$source" ]; then
      echo "Warning: $destination exists and does not link to $source" >&2
    fi
  fi
}
