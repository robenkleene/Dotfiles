- `vim -r`: Launch Vim showing where swap files are located (e.g., have an open instance of Vim with unsaved changes, then run `vim -r` in the same directory to list the swap files)
- `:recover`: Recover the current file from a swap file

# Differences

To view the differences between the `.swp` file and the current file.

1. Edit the file and recover the `.swp`, after this the buffer will be the `.swp` contents, but the current file hasn't changed yet
2. Run `:w !diff % -` to see a diff of the buffer contents versus the unchanged file on disk
