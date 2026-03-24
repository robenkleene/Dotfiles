# `xargs`

- `-0`: Use NUL byte terminator
- `-I '{}'`: Execute each command separately replacing `{}` with the match

## Examples

Copy files with search term to directory:

```
rg '<search-term>' -l -0 | xargs -I '{}' -0 cp -I '{}' '<dest-dir>'
```
