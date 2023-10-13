%

# `cargo` Run

- `cargo run -- <arg1> <arg2>`: Run with arguments (the `--` is optional)

## Running Single Files

`cargo new <project>` will have created a directory structure with `Cargo.toml` and `src/` directory.

1. Add a `src/bin` directory and add single `<filename>.rs` files in it
2. To run them, use `cargo run --bin <filename>`
3. To run tests, use `cargo test --bin <filename>`
