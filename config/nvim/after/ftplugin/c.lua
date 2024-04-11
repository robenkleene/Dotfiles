-- Since Neovim uses `vim.bo` for `commentstring` (which Vim doesn't support, see `h vim:bo`), it can't be overridden from Vimscript
vim.bo.commentstring = '// %s'
