%

# `vim` `coc`

- If Coc doesn't appear to be working, e.g., if `CocInfo` prints nothing, try running `yarn install` in the `Coc.vim` plugin directory.
- Extensions listed in `g:coc_global_extensions` are auto-installed, old extensions have to be removed manually with `CocUninstall coc-python`.
- Extensions are installed at `.config/coc/extensions/node_modules`
- Extensions cannot be automatically uninstalled, they must be uninstalled with `:CocUninstall`
- `CocList extensions`: List installed extensions
- When `yarn install` needs to be run, it needs to be run at the plugin directory (probably `~/Developer/Dotfiles/vim/plugged/coc.nvim`). You can use `yarn install --ignore-engines` if there's errors about the Node version.
