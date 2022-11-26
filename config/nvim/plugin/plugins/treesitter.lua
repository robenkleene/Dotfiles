require('nvim-treesitter.configs').setup {
  -- `query` for treesitter playground
  ensure_installed = {
    'bash',
    'c',
    'comment',
    'cpp',
    'lua',
    'javascript',
    'html',
    'markdown',
    'markdown_inline',
    'python',
    'query',
    'rust',
    'toml',
    'typescript'
  },
  highlight = { enable = true },
  indent = { enable = true },
  -- Trying to customize Markdown colors, this doesn't work for some reason
  custom_captures = {
    ["text.uri"] = "Comment",
    ["punctuation.delimiter"] = "Comment",
  }
}
