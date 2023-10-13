# Cargo `lldb`

1. `lldb target/debug/reap`
2. `process launch` (or `process launch -i tests/data/grep.txt`)

## Tests

To run a test in `lldb` we first need the path to the compiled test binary, which is printed out when `cargo test` is run, it looks like this:

    target/debug/deps/<project-name>-d1d452730bf9464b

Note that `cargo tests` runs *two test targets*, one for integration tests and one for unit tests, you'll need to get the path to the target that's running the code you want to debug (e.g., either the test itself, or the project).

- Use `rust-lldb` for niceties like pretty printing (I couldn't get this to work with a non-default `lldb` install location like on Linux).

1. Run `rust-lldb target/debug/deps/<project-name>-d1d452730bf9464b`
2. Set breakpoints, e.g., `b src/file.rs:20`
3. In `lldb` run `run <test-name>` (or `run --test <test-name>`)

### Troubleshooting

## Installed

1. `cargo install --path . --debug`
2. `lldb .cargo/bin/reap`
3. Set breakpoints, e.g., `b src/file.rs:20`

## CLI Tests

CLI tests (e.g., using `Command::cargo_bin("rep")`) involve two different binaries, one is the CLI binary, and the other is the test binary. You can use the normal method above for the test binary, but for the CLI binary, you'll need to do some extra steps to add `get-task-allow`.

1. Add the `get-task-allow` flag to the binary (this is the built binaries path, e.g., `target/debug/rep`, which doesn't appear in the `cargo test` compilation output)
2. `rust-lldb`
3. `(lldb) process attach -n <binary-name> -w` (`-n`: `--name`, `-w`: `--waitfor`)
4. `cargo test <test-name>`
    - *Note you have to be sure this doesn't overwrite the binary by re-compiling*
    - `<test-name>` seems to be required for this to work for some reason
5. When the test starts running the debugger will immediately pause execution, and then breakpoints can be entered, e.g. `b /Users/robenkleene/Developer/Projects/CLI/rep-grep/src/patcher.rs:24`, then follow-up with `c` for continue to hit the breakpoint

### `get-task-allow`

#### Adding

`=(...)` is special `zsh` process substitution that creates a temporary file containing the output of the command, and then uses that temporary file as the parameter.

```
codesign -s - -v -f --entitlements =(echo -n '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "https://www.apple.com/DTDs/PropertyList-1.0.dtd"\>
<plist version="1.0">
    <dict>
        <key>com.apple.security.get-task-allow</key>
        <true/>
    </dict>
</plist>') <binary-path>
```

#### Verifying

`codesign -dvvv --entitlements=- <path-to-app>`
