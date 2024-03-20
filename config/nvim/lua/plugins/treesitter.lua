return {
  'nvim-treesitter/nvim-treesitter',
  -- Not `VeryLazy` because it can cause a flash of re-highlighting otherwise
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
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
        "ruby",
        'rust',
        'toml',
        'typescript',
        'vim',
      },
      modules = {},
      auto_install = false,
      ignore_install = { "all" },
      -- Trying to prevent the constant re-installing
      sync_install = false,
      build = ":TSUpdate",
      highlight = { enable = true },
      textobjects = {
        -- Use these for languages that don't use braces and therefore don't support Vim's built-in function navigation with `[m`, `[M`, etc...
        move = {
          enable = true,
          set_jumps = true,
          goto_previous_start = {
            ["<localleader>[m"] = "@function.outer",
          },
          goto_next_start = {
            ["<localleader>]m"] = "@function.outer",
          },
          goto_previous_end = {
            ["<localleader>[M"] = "@function.outer",
          },
          goto_next_end = {
            ["<localleader>]M"] = "@function.outer",
          },
        },
      },
    }
  end
}
