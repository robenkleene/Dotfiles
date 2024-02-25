# `sed`

- `-i`: Replace in files, note that for macOS this needs to be `-i ''`

## Remove Spaces

	sed 's/ //g'

## Replace Multiple Spaces With One Space

	sed "s/  */ /g"

## Capture Groups

	sed 's/.*:\(.*\):.*/\1/p'`

Another example:

    sed -E 's/^( *-) */\1 /g'

Note that the `-E` flag inverts whether the parentheses need to be escaped.

## Delete a Line

    sed -i `1d` ~/.ssh/known_hosts

## Insert a Line

Note the `\` and new line are necessary:

    sed -i '' "307i\
    @@ -468,7 +468,7 @@" markdown-markup.patch

In a script:

    line_fix='307i\
    @@ -468,7 +468,7 @@'
    sed -i '' "${line_fix}" markdown-markup.patch

Appending to the last line of a file:

    line_fix='$a\
    \\ No newline at end of file
    '
    sed -i '' "${line_fix}" patch.patch

## Files

### With `rg`

    rg Raster -l -0 | xargs -0 sed -n 's/Raster/Cyclist/gp'

### Recursive

    sed -n 's/Raster/Cyclist/gp' **

- `-n` / `--quiet` / `--silent`: Don't print every matching line
- `/p`: Output each matching line
- Don't run it like this (without removing the `p`), because it will double each replaced line
