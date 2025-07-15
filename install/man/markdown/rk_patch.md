- Pipe a patch to `patch` to apply it
- `--merge` apply conflicts in the file (instead of creating `.rej` files) note that the built in version of `patch` on macOS doesn't support this

# Tricks

To apply a patch to an arbitrary file, just remove the section of the patch that specifies the file path, `patch` will then prompt for a file path to apply it to.

# Troubleshooting

- For `can't find file to patch at input line X` errors, use `-pN` where `N` is the number of leading components to strip (e.g., to clean a path like `a/foo/bar`, `-p1` would strip the first component which is `a/`
