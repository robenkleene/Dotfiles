%

# Emacs Use Package

- If a package fails to install, just try `package-refresh-contents` then try again.
- `init` is run at Emacs startup, `config` is run after the package is loaded
- `:ensure t`: Install package automatically (this isn't necessary with `use-package-always-ensure`
- `:defer t`: Wait till after `autoload` to load (implied by `:command`, `:mode`, or `:bind`)
