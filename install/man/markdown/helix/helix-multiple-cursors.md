%

# Helix Multiple Cursors

- `A-s`: Split selection on new lines (e.g., make a cursor on each line)
- `,`: Remove multiple cursors
- `C`: Add cursor to "next suitable line"
- `s`: With an active selection, search for a phrase in the selection and select it, e.g., to change multiple occurrences
- `S`: With an active selection, make multiple cursors for each occurrence

## Find & Replace

1. Select text to search for
2. Hit `*` to put it in the search register (to replace in the whole document, skip 2-5 and hit `%` then `s` then `enter`)
3. Hit `v` to enter select mode
4. Hit `n` to select more instances
5. Hit `c` (or `r`) to replace all selected instances

Use `(` / `)` to jump between matches, and `A-,` to remove a match

## Processing Shell Output

1. With shell content on the clipboard, open a new document with `hx`
2. Use `<space>R` to replace the contents of the buffer with the clipboard contents
3. The text should already be selected, so use `A-s` to start editing with multiple cursors
