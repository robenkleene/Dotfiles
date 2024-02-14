- `s/foo/bar`
- `s#foo#bar`: Alternative syntax, very useful for replaces that involve a lot of slashes.
- `&` / `:&` repeat last substitute but without the flags (e.g., `g` is a flag to replace all matches)
- `:&&`: Repeat the last substitute but with the same flags

# Notes

- `&` represents the entire match, e.g., in `%s/a file/mv "&" "&"`

# `windo`

- `windo %s/foo/bar/g`: Replace in all open windows
