- `ya pkg add <id>`: Install a plugin and add it to `~/.config/yazi/package.toml` (e.g., `ya pkg add yazi-rs/plugins:toggle-pane`)
- `ya pkg install`: Install all plugins in `package.toml` at their pinned revisions (e.g., to sync plugins on another machine)
- `ya pkg upgrade`: Upgrade all plugins to their latest revisions
- `ya pkg list`: List installed plugins
- `ya pkg delete <id>`: Delete a plugin

# Pinning a Revision

To pin an older revision:

1. In `package.toml`, set `rev` to the revision and set `hash = ""`
2. Run `ya pkg install`, which installs that revision and fills in `hash`

`ya pkg upgrade` moves pinned plugins back to their latest revisions.
