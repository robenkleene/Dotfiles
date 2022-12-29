return {
  { "gpanders/editorconfig.nvim", event = "VeryLazy" },
  { "tpope/vim-vinegar", event = "VeryLazy" },
  {
    'tpope/vim-eunuch',
    cmd = { 'Rename', 'Remove' }
  },
  { "numToStr/Comment.nvim", config = true },
  {
    'L3MON4D3/LuaSnip',
    event = "VeryLazy",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/Code/User/snippets" } })
      vim.cmd([[
        imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
        ]])
    end
  },
  { "NvChad/nvim-colorizer.lua", config = true, event = "VeryLazy" },
  { "kylechui/nvim-surround", config = true, event = "VeryLazy" },
  {
    -- Use `B` command to pipe just part of a visual selection
    'vim-scripts/vis',
    cmd = "B"
  },
  { 'github/copilot.vim', event = "VeryLazy" },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      vim.g.catppuccin_flavour = "mocha"
      require("catppuccin").setup()
      vim.cmd [[colorscheme catppuccin]]
    end
  },
  { 'j-hui/fidget.nvim', event = "VeryLazy" },
  {
      'nvim-treesitter/playground',
      cmd = 'TSPlaygroundToggle'
  },
  -- Languages
  { 'dag/vim-fish', ft = { 'fish' }, }
}
