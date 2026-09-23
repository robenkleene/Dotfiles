- `vim -r`: Launch Vim showing where swap files are located (e.g., have an open instance of Vim with unsaved changes, then run `vim -r` in the same directory to list the swap files)
- `:recover`: Recover the current file from a swap file

# Menu

If a `.swp` file exists for the file being edited, a menu will be presented with options. *The `(D)elete` option will only be available if the process that created the `.swp` file isn't running.* So if delete is not present then another instance of Vim is probably editing this file.

# Differences

To view the differences between the `.swp` file and the current file.

1. Edit the file and recover the `.swp`, after this the buffer will be the `.swp` contents, but the current file hasn't changed yet
2. Run `:w !diff % -` to see a diff of the buffer contents versus the unchanged file on disk
3. Changes will be shown with the current file prefixed with `<` and changes from the buffer (`.swp`) will be shown with prefixed with `>`
4. After saving or discarding changes, `:e` will get back the menu again where the option to delete the `.swp` file can be chosen

## Example

```
< Current file
---
> Swamp file
```
