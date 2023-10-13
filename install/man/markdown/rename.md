# `rename`

- `-n, --dry-run, --just-print`

Remove the `-n` to execute.

## Recursive

    rename 's/raster/cyclist/g' **

## With `fd`

    fd raster -0 | xargs -0 rename -n 's/raster/cyclist/g'

