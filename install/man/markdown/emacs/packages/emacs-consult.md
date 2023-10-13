# Emacs Consult

## `rg`

- Flags after `#TODO -- -g *.el` (`fd` should be `-- -g "*.{js,ts}"` but that doesn't work, maybe because with `fd` you have to omit the search term?)
- A second `#` to add Vertico searches after `rg` filtering, e.g., `#TODO#!today` will return for all matches for `TODO` from `rg` and then filter those in Vertico to remove lines that match `today`.
