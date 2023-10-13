%

# Homebrew

- `brew update`: Update homebrew itself
- `brew upgrade <package>`: Brew update package or everything if it's omitted

## Dependencies

- `brew leaves`: Show top level installed packages
- `brew deps --tree --installed`: Show a dependency graph
- `brew deps neovim`: List dependencies of a package
- `brew uses --installed gettext`: List packages that depend on a package
