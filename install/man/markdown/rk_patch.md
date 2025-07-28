- Pipe a patch to `patch` to apply it
- `--merge` (or `--merge=diff3` to use `diff3` style which also includes the contents before either conflicting change) apply conflicts in the file instead of creating `.rej` files (note that the built in version of `patch` on macOS doesn't support this, so instead use, e.g., `gpatch --merge=diff3`)

# Tricks

To apply a patch to an arbitrary file, just remove the section of the patch that specifies the file path, `patch` will then prompt for a file path to apply it to.

# Troubleshooting

- For `can't find file to patch at input line X` errors, use `-pN` where `N` is the number of leading components to strip (e.g., to clean a path like `a/foo/bar`, `-p1` would strip the first component which is `a/`
