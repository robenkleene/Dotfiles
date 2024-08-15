# Fish Pros

- `vim (pbpaste)` works in Fish but not `zsh`
- `zsh` is less reliably about completing command-line flags
- Fish universal variables can be synced without restarting Fish, e.g., so configuration changes don't require spawning a new shell
- Fish has a binding for copying the current command line built-in
- Fish is faster
- Fish requires less configuration (and is therefore less problem prone)
- Fish `^R` search is more powerful, e.g., type `rg` `↑` then `^R` to search just `rg` commands for a term
- Fish has less bugs (e.g., when connected via `mosh` sometimes need to do `exec zsh` to fix colors)
- Fish is in more active development
- Fish is faster

# Zsh Pros

- More ubiquitous
- Works more like other programs, Fish features feel missing when writing commands in Vim's command line for example
- Better completion support for some older CLI tools
