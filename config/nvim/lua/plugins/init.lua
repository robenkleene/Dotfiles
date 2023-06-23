return {
  -- Indent is broken if `VeryLazy` is set
  { "gpanders/editorconfig.nvim" },
  {
    'tpope/vim-eunuch',
    cmd = { 'Rename', 'Remove' }
  },
  { "numToStr/Comment.nvim",     config = true, event = "VeryLazy" },
  {
    "levouh/tint.nvim",
    event = "VeryLazy",
    config = function()
      require("tint").setup({
        -- tint_background_colors = true,
        highlight_ignore_patterns = { "EndOfBuffer", "Tab.*", ".*LineNr" }
      })
    end
  },
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
        { expr = true, silent = true })
    end
  },
  { "NvChad/nvim-colorizer.lua", config = true, event = "VeryLazy" },
  { "kylechui/nvim-surround",    config = true, event = "VeryLazy" },
  {
    -- Use `B` command to pipe just part of a visual selection
    'vim-scripts/vis',
    cmd = "B"
  },
  {
    'luukvbaal/nnn.nvim',
    config = function()
      require("nnn").setup({
        replace_netrw = "picker",
      })
      vim.keymap.set('n', '-', ":NnnPicker<CR>")
    end,
    cmd = { "NnnPicker", "Explore" },
    keys = {
      { '-' },
    }
  },
  {
    'nvim-treesitter/playground',
    cmd = 'TSPlaygroundToggle'
  },
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle'
  },
  { 'samjwill/nvim-unception' },
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
