%

# Rust CLI Apps

- `cargo run | cat`: Will pipe through a command

## `atty`

`true` if `STDOUT` is not a TTY

```
let is_tty = atty::is(atty::Stream::Stdout);
```
