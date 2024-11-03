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
        'diff',
        'lua',
        'java',
        'javascript',
        -- Causing an error on quit that `syntax/kotlin.vim` can't be found, probably need to install a plugin to enable this?
        -- 'kotlin',
        -- 'help',
        'html',
        'markdown',
        'markdown_inline',
        'objc',
        'python',
        'query',
        "ruby",
        'rust',
        'toml',
        'swift',
        'typescript',
        'vim',
        'vimdoc',
      },
      modules = {},
      auto_install = false,
      ignore_install = { "all" },
      -- Trying to prevent the constant re-installing
      sync_install = false,
      -- Try to fix crashes on Markdown by disabling `indent`
      -- If we ever want to enable this, turn of `smartindent`
      indent = false,
      build = ":TSUpdate",
      highlight = { enable = true },
      textobjects = {
        -- Use these for languages that don't use braces and therefore don't support Vim's built-in function navigation with `[m`, `[M`, etc...
        move = {
          enable = true,
          set_jumps = true,
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
        },
      },
    }
    vim.keymap.set('n', '<localleader>[m', '[m')
    vim.keymap.set('n', '<localleader>]m', ']m')
    vim.keymap.set('n', '<localleader>[M', '[M')
    vim.keymap.set('n', '<localleader>]M', ']M')
    vim.keymap.set('n', '<localleader>[[', '[[')
    vim.keymap.set('n', '<localleader>]]', ']]')
    vim.keymap.set('n', '<localleader>[]', '[]')
    vim.keymap.set('n', '<localleader>][', '][')
  end
}
