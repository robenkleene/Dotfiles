%

# `less`

- `-i`: Ignore case (also use *inside of less* to toggle case-sensitivity)
- To dump everything to the terminal, use `--no-init` and then hit `G q` to jump to the bottom and quit

## Git Pager Settings

Command to do `less` like `git` pager:

	less -FXRS

* `-F` / `--quit-if-one-screen`: Quit if output is shorter than one screen
* `-X` / `--no-init`: Don't re-draw the screen after quit
* `-R` / `--RAW-CONTROL-CHARS`: Allow color
* `-S` / `--shop-long-lines`: Truncate long lines

## Bindings

- `''`: Go to previous position (e.g., to return how you started after a search)

## Search

`/\W-<flag`: Search for a short flag (`\W` matches a word boundary)

## Interactive

- `-S`: Type and hit enter to toggle wrap

## Tips

To search for a flag, prefix it with a space, e.g., ` --foo`.
