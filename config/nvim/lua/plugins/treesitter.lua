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
      -- indent = { enable = true },
      -- Trying to customize Markdown colors, this doesn't work for some reason
      -- custom_captures = {
      --   ["text.uri"] = "Comment",
      --   ["punctuation.delimiter"] = "Comment",
      -- },
      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            -- You can optionally set descriptions to the mappings (used in the desc parameter of
            -- nvim_buf_set_keymap) which plugins like which-key display
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            -- You can also use captures from other query groups like `locals.scm`
            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
          },
          -- You can choose the select mode (default is charwise 'v')
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * method: eg 'v' or 'o'
          -- and should return the mode ('v', 'V', or '<c-v>') or a table
          -- mapping query_strings to modes.
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * selection_mode: eg 'v'
          -- and should return true of false
          include_surrounding_whitespace = true,
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["<localleader>]m"] = "@function.outer",
            ["<localleader>]]"] = { query = "@class.outer", desc = "Next class start" },
            --
            -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
            ["<localleader>]o"] = "@loop.*",
            -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
            --
            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
            ["<localleader>]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            ["<localleader>]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
          },
          goto_next_end = {
            ["<localleader>]M"] = "@function.outer",
            ["<localleader>]["] = "@class.outer",
          },
          goto_previous_start = {
            ["<localleader>[m"] = "@function.outer",
            ["<localleader>[["] = "@class.outer",
          },
          goto_previous_end = {
            ["<localleader>[M"] = "@function.outer",
            ["<localleader>[]"] = "@class.outer",
          },
          -- Below will go to either the start or the end, whichever is closer.
          -- Use if you want more granular movements
          -- Make it even more gradual by adding multiple queries and regex.
          goto_next = {
            ["<localleader>]d"] = "@conditional.outer",
          },
          goto_previous = {
            ["<localleader>[d"] = "@conditional.outer",
          }
        },
      },
    }
  end
}
