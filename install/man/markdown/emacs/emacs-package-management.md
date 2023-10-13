# `emacs` Package Management

- `M-x package-list-packages`: List Packages
- `i`: Mark selected package for installation
- `d`: Mark selected package for deletion
- `u`: Un-mark selected package
- `U`: Update all packages
- `x`: Execute commands on marked packages

## Upgrading

- `M-x package-autoremove`: Delete unused packages
- `~`: Mark obsolete packages for deletion (then `x` to execute)

## Removing

1. Remove any files related to the package (e.g., where we use `use-package` to install)
2. Quit Emacs
3. Manually remove the package form the `package-selected-packages` variable in `custom.el`. 
4. Run Emacs then run `package-autoremove`

## Troubleshooting

If a package won't install, try `package-refresh-contents`.
