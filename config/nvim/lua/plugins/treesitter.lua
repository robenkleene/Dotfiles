return {
  'nvim-treesitter/nvim-treesitter',
  -- Not `VeryLazy` because it can cause a flash of re-highlighting otherwise
  -- event = "VeryLazy",
  -- Set the same for cmp, treesitter, lsp
  ft = {
    "c",
    "cpp",
    "css",
    "html",
    "javascript",
    "json",
    "jsx",
    "kotlin",
    "lua",
    "markdown",
    "python",
    "ruby",
    "rust",
    "scss",
    "sh",
    "typescript",
    "toml",
    "vim",
  },
  config = function()
    require('nvim-treesitter.configs').setup {
      -- `query` is for treesitter playground
      -- `c`, `lua`, `help`, and `vim` are installed by default by Neovim, so
      -- they must be present otherwise the default versions will be found by
      -- the treesitter plugin which are incompatible.
      -- See the directories where parsers are found:
      -- `:echo nvim_get_runtime_file('parser', v:true)`
      ensure_installed = {
        'bash',
        'c',
        'comment',
        'cpp',
        'lua',
        'javascript',
        'kotlin',
        -- 'help',
        'html',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'rust',
        'toml',
        'typescript',
        'vim',
      },
      -- Trying to prevent the constant re-installing
      sync_install = false,
      build = ":TSUpdate",
      highlight = { enable = true },
      -- indent = { enable = true },
      -- Trying to customize Markdown colors, this doesn't work for some reason
      custom_captures = {
        ["text.uri"] = "Comment",
        ["punctuation.delimiter"] = "Comment",
      }
    }
  end
}
