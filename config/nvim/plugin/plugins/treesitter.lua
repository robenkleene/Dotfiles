require('nvim-treesitter.configs').setup {
  -- `query` for treesitter playground
  ensure_installed = { 'c', 'cpp', 'lua', 'markdown', 'markdown_inline', 'python', 'query', 'rust', 'typescript' },
  highlight = { enable = true },
  indent = { enable = true },
  -- Trying to customize Markdown colors, this doesn't work for some reason
  custom_captures = {
    ["text.uri"] = "Comment",
    ["punctuation.delimiter"] = "Comment",
  }
}
