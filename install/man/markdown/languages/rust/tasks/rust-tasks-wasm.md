%

# Rust `wasm`

The dependencies are `wasm-pack` (install via Homebrew) and  `cargo-generate`

1. Setup project with `cargo generate --git https://github.com/rustwasm/wasm-pack-template`
    - This prompts for a name
2. Verify it builds with `wasm-pack build`
3. From project root, run `npm init wasm-app www`
    - This will ask to install the `create-wasm-app` package
    - This will make the `www` subdirectory
    - The `www` is will have it's own `.git` directory, you probably want to delete this `rm -rf www/.git`
4. Run `npm install` in `www`
