%

# Bash Parameter Expansion

- `${var:-$default}`: Use `default` if `var` isn't set
- `${var:?an error}`: Print `an error` and exit if `var` isn't set.
- `${#var}`: Length of `var`.
- `${var#pattern}`: Remove `pattern` prefix.
- `${var%pattern}`: Remove `pattern` suffix.
- `${var/foo/bar}`: Replace `foo` with `bar` in `var` once.
- `${var//foo/bar}`: Replace `foo` with `bar` in `var` globally.
- `${var:offset:length}`: A substring of `var`.

## Examples

    directory=${filename##*/}
    extension=${filename##*.}
