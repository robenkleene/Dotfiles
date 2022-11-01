require('nvim-treesitter.configs').setup {
  -- `query` for treesitter playground
  ensure_installed = { 'c', 'cpp', 'lua', 'markdown', 'markdown_inline', 'python', 'query', 'rust', 'typescript' },
  highlight = { enable = true },
  indent = { enable = true },
}
