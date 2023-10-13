%

# `zsh` `zmv`

- `zmv` is a renaming function built in to zsh

## Examples

    zmv -n '(**/)(*).jade' '$1$2.pug'
    zmv -n '(**/)jade' '$1pug'

- `-n` is dry run, remove it to execute
