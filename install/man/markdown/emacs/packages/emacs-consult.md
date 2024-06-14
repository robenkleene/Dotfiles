# `rg`

- `M-n` will insert the thing at point
- Flags after `--` are passed to the underlying command `<term> -- -g *.el` (note this doesn't work with `'*.el'`, and `fd` should be `-- -g "*.{js,ts}"` but that doesn't work, maybe because with `fd` you have to omit the search term?)
    - For some reason, single quotes don't work when passing flags this way, e.g., `-g "*.cpp"` will work but not `-g '*.cpp'`
- A second `#` to add Vertico searches after `rg` filtering, e.g., `#TODO#!today` will return for all matches for `TODO` from `rg` and then filter those in Vertico to remove lines that match `today`.

## Consult Buffers

- `consult-buffers` contains `Buffers`, `Files`, and `Bookmarks` these can be filter by typing a letter to represent a group followed by space. E.g., `b SPC` will search for buffers, `f SPC` will search files, and `m SPC` will search bookmarks. `DEL` will then go back to searching everything.
