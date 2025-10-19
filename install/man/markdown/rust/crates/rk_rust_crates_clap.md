# Rust Crates `clap`

"Command Line Argument Parser for Rust."

## Example

The `derive` `Parser` annotation on `struct Args` means treat that `struct` as arguments:

``` rust
/// Simple program to greet a person
#[derive(Parser, Debug)]
#[command(version, about, long_about = None)]
struct Args {
    /// Name of the person to greet
    #[arg(short, long)]
    name: String,

    /// Number of times to greet
    #[arg(short, long, default_value_t = 1)]
    count: u8,
}
```

