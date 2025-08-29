
# Modifiers

- `${#var}`: Length of variable
- `${EDITOR:-vim}`: Default value
- `${CODESPACES-}`: Use an unset variable without causing an error with `set -u` / `set -o nounset` on
- `${var:?some error}`: Prints "some error" and exits of var is null or unset
- `${var#pattern}`: Remove prefix
- `${var%pattern}`: Remove suffix
- `${var/bear/panda}`: Replace in var once
- `${var//bear/panda}`: Replace in var global
- `${var:offset:length}`: Get a substring of var
