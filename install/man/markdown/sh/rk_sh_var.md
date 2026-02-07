- `IFS`: Internal Field Separator, defaults to whitespace (space, tab, newline)

# Parameter Expansion

- `${var:-$default}`: Use `default` if `var` isn't set
- `${var:?an error}`: Print `an error` and exit if `var` isn't set.
- `${#var}`: Length of `var`.
- `${var/foo/bar}`: Replace `foo` with `bar` in `var` once.
- `${var//foo/bar}`: Replace `foo` with `bar` in `var` globally.
- `${var:offset:length}`: A substring of `var`.

## Patterns

- `${variable#pattern}`: Trim the shortest match from the beginning (e.g., trim pattern suffix)
- `${variable##pattern}`: Trim the longest match from the beginning
- `${variable%pattern}`: Trim the shortest match from the end (e.g., trim pattern prefix)
- `${variable%%pattern}`: Trim the longest match from the end

## Paths

- `${path##*/}`: Filename (e.g., `dir/foo.bar` to `foo.bar`)
- `${path%/*}`: Directory (e.g., `dir/foo.bar` to `dir`)
- `${filename##*.}`: Extension (e.g., `foo.bar` to `bar`)
- `${filename%.*}`: Filename without extension (e.g., `foo.bar` to `foo`)
