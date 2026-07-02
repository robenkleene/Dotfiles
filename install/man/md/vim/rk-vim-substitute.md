- `:s/foo/bar`
- `:%s/foo/bar/gc`: Replace this with that, asking for confirmation each time
- `:%s#foo#bar#g`: Alternative find and replace separator for when the find and replace strings themselves include slashes
- `&` / `:&` repeat last substitute but without the flags (e.g., `g` is a flag to replace all matches)
- `:&&`: Repeat the last substitute but with the same flags

# Notes

- `&` represents the entire match, e.g., in `%s/a file/mv "&" "&"`
- Use `\r` for a new line in a substitution, e.g., `s/ /\r/g` replaces all spaces with new lines

# `windo`

- `windo %s/foo/bar/g`: Replace in all open windows
