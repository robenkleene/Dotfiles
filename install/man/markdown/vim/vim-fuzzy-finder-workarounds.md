# Vim Fuzzy Finder Workarounds

- `ls`: List buffers
- `b <term><tab>`: Tab complete a file in the buffer list based on part of it's name
- `find **/*.<extension>`: Recursively match a file
- `:[ol]dfiles`: Recent files
    - You can hit `:` in this list to enter an edit command, e.g., `e #<1` to edit old file number `1`
- `:bro[wse] [ol]dfiles`: Open a recent file
- `:g/cfcfcf/p`: Print lines matching pattern
- `:vimgrep /pattern/ %`: Add patterns matching line to quickfix list

## Old Files

- `:e #<1`: Edit most recent file
- `:e #<2`: Edit second most recent file
