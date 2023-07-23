return {
  -- Indent is broken if `VeryLazy` is set
  { "gpanders/editorconfig.nvim" },
  {
    'tpope/vim-eunuch',
    cmd = { 'Rename', 'Remove' }
  },
  {
    "numToStr/Comment.nvim",
    config = true,
    event = "VeryLazy"
  },
  { 'tpope/vim-vinegar' },
  -- Opening files from oil can cause `ftplugin` to not fire, as a workaround just use the fuzzy finder instead
  -- {
  --   'stevearc/oil.nvim',
  --   config = function()
  --     require("oil").setup()
  --     vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
  --   end
  -- },
  {
    'L3MON4D3/LuaSnip',
    -- This can't co-exist with GitHub Copilot
    -- keys = {
    --   { '<Tab>', mode = "i" },
    -- },
    event = "VeryLazy",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/Code/User/snippets" } })
      vim.api.nvim_set_keymap(
        'i', '<Tab>',
        'luasnip#expand_or_jumpable() ? "<Plug>luasnip-expand-or-jump" : "<Tab>"',
        { expr = true, silent = true }
      )
      local luasnip = require 'luasnip'
      -- Make sh snippets available to zsh
      luasnip.filetype_extend("zsh", { "sh" })
    end
  },
  { "NvChad/nvim-colorizer.lua", config = true, event = "VeryLazy" },
  { "kylechui/nvim-surround", config = true, event = "VeryLazy" },
  {
    -- Use `B` command to pipe just part of a visual selection, e.g., `B !sort`
    'vim-scripts/vis',
    cmd = "B"
  },
  {
    'nvim-treesitter/playground',
    cmd = 'TSPlaygroundToggle'
  },
  { 'samjwill/nvim-unception', },
  { 'bogado/file-line', },
  -- Themes
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   config = function()
  --     require("catppuccin").setup()
  --     vim.cmd("colorscheme catppuccin")
  --   end
  -- },
  {
    "folke/tokyonight.nvim",
    config = function()
      vim.cmd("colorscheme tokyonight-night")
    end
  },
  -- {
  --   "EdenEast/nightfox.nvim",
  --   config = function()
  --     vim.cmd("colorscheme carbonfox")
  --   end
  -- },
  -- {
  --   "whatyouhide/vim-gotham",
  --   config = function()
  --     vim.cmd("colorscheme gotham")
  --   end
  -- },
  -- {
  --   "rose-pine/neovim",
  --   config = function()
  --     vim.cmd("colorscheme rose-pine")
  --   end
  -- },
  -- {
  --   "rebelot/kanagawa.nvim",
  --   config = function()
  --     vim.cmd("colorscheme kanagawa-wave")
  --   end
  -- },
  -- Languages
  { 'dag/vim-fish',           ft = { 'fish' }, }
}
