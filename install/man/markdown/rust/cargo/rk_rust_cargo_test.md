- `cargo test <term>`: Run all tests that match term
- `cargo test cli::nested_delete -- --exact`: Run a test by exact name
- `cargo test -- --list`: List available tests

# Flags

- `--message-format short`: Emit error messages in a simpler format that's easier for other programs to parse (e.g., `:make` in Vim)

# Binary

These options are passed to the test binary and therefore *go after the `--`*.

- `cargo test -- --nocapture`: Don't suppress output for successful tests

# Diff

In test diff output, the expected output is shown first.
