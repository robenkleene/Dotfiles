- `:lua vim.lsp.diagnostic.set_quickfixlist()`

## Calling Vimscript

### One Line

```
vim.cmd('syntax enable')
```

```
vim.cmd([[
  highlight Error guibg=red
  highlight link Warning Error
]])
```
