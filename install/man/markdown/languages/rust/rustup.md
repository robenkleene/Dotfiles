%

# Rustup

- `rustup show`: Show installed toolchains
- `rustup check`: Show available updates
- `rustup update`: Update Rust

## Components

- `rustup component list`: List installed components
- `rustup component add rust-analyzer`: Install a component

## Troubleshooting

If Rust LSP isn't working after upgrading rust, probably need to run `rustup component add rust-analyzer` (check if it's installed first with `rustup component list`).
