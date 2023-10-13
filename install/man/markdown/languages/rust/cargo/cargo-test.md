# `cargo` Test

- `cargo test <term>`: Run all tests that match term
- `cargo test cli::nested_delete -- --exact`: Run a test by exact name

## Binary

These options are passed to the test binary and therefore *go after the `--`*.

- `cargo test -- --nocapture`: Don't suppress output for successful tests

## Diff

In test diff output, the expected output is shown first.
