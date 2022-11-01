require('nvim-treesitter.configs').setup {
  ensure_installed = { 'c', 'cpp', 'lua', 'markdown', 'python', 'rust', 'typescript' },
  highlight = { enable = true },
  indent = { enable = true },
}
