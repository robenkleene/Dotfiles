- `-i`: Ignore case (also use *inside of less* to toggle case-sensitivity)
- To dump everything to the terminal, use `--no-init` and then hit `G q` to jump to the bottom and quit

# Git Pager Settings

Command to do `less` like `git` pager:

	less -FXRS

* `-F` / `--quit-if-one-screen`: Quit if output is shorter than one screen
* `-X` / `--no-init`: Don't re-draw the screen after quit
* `-R` / `--RAW-CONTROL-CHARS`: Allow color
* `-S` / `--shop-long-lines`: Truncate long lines

# Bindings

- `H`: Show help including bindings
- `''`: Go to previous position (e.g., to return how you started after a search)

# Search & Filter

`/\W-<flag`: Search for a short flag (`\W` matches a word boundary)
- `&`: Show only matching lines (hit `&` again with an empty search)
- There's no way to exit a search or filter in `less`, the only thing you can do is hit enter (`⌃C` kind of works, but this has side effects like killing an incoming pipe)
- `⌥U`: Un-highlight search matches

# Follow Mode

- `less +F`: Start less in follow mode
- `⇧F`: Enter follow mode with `less` running
- `⌃X`: Exit follow mode (this does not break an incoming pipe)

## Filter

1. Launch with `+F`, e.g., `adb logcat | less +F`
2. `⌃X` to exit follow mode
3. `&` to filter the messages
4. `⇧F` to re-enable follow mode

# Interactive

- `-S`: Type and hit enter to toggle wrap

# Tips

To search for a flag, prefix it with a space, e.g., ` --foo`.
