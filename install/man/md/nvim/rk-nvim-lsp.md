- `grn`, `vim.lsp.buf.rename()`
- `gra`, `vim.lsp.buf.code_action()`
- `grr`, `vim.lsp.buf.references()`
- `<c-s>`, `vim.lsp.buf.signature_help()`
- `K`, `vim.lsp.buf.hover()`
- `<c-w>d`, `vim.diagnostic.open_float()`
- `gq`: Operator to format document

# Tags

- `tagfunc` can be set to `v:lua.vim.lsp.tagfunc` which will use LSP tag definition lookup instead of tags. Set `vim.bo[ev.buf].tagfunc = nil` to use tags instead.

# Functions

- `:lua vim.diagnostic.setqflist()`: Populate quickfix list with diagnostics
- `:lua vim.diagnostic.setloclist()`: Populate location list with diagnostics
- `:lua vim.diagnostic.disable()` / `:lua vim.diagnostic.enable()`: Disable / enable diagnostics
- `:lua vim.diagnostic.show()` / `:lua vim.diagnostic.hide()`: Show / hide diagnostics (e.g., the gutter indicators)
