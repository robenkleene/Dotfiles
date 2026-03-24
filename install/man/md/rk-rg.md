`rg` is case sensitive by default, this is to be consistent with `grep` which is also case sensitive by default.

- `-i` & `--ignore-case`: Ignore case
- `-s` & `--case-sensitive`: Case sensitive
- `-F`: Literal (no regular expression) search
- `--null`: Use `NUL` byte terminator
- `--no-ignore`: Include ignored files
- There's no option to print full paths, but `rg <search term> $PWD` works as a workaround

# Filenames

- `-l` & `--files-with-matches`: List files with matches
- `-g` or `--glob`: Filter by filename
- `--files`: Print each file but don't search
- `--files -g`: Search for files matching glob.

## Globs

- To match multiple file extensions, use a character group: `rg -g '*.[hm]'`, `-g "*.{m,h,swift}"`
- To do a negative glob, precede with `!`, e.g., `rg -g "\!*.html" import`
- An example of the above techniques being combined: `rg -s executable -g "\!{handlers,fixers}/*"`
- Multiple globs can be combined, e.g., to filter based on an extension, and exclude a directory `-g '!Test' -g '*.{h,cpp}'`
- Note that in `rg` globs are case sensitive (in `fd` globs are case insensitive)

# Examples

- `rg -U --multiline-dotall "string1.*string2" -g "*.m"`
- `-U`: Enable multi-line search
- `--multiline-dotall`: Allow `.` to match newlines (alternatively, `(?s:.)` can be replace `.` to match new lines)
- `rg -IN -m 1 ".*import.*"`: Print matching lines, max 1 per file, good for quickly remembering how to do something

# Troubleshooting

- To search for hyphens, precede the search term with `--`, e.g., `rg -- --bind`
