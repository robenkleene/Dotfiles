%

# `vim` Change Directory

- `cd %`: When viewing a directory in `netrw`. This will not work when the filename says "No Name" in `netrw`, this appears to be a bug. When this happens the best fix is to just edit a file in the directory and do `cd %:h`.
- `cd %:h`: Go to the parent directory when editing a file.
