return {
  { "gpanders/editorconfig.nvim" },
  { "tpope/vim-vinegar" },
  {
    'tpope/vim-eunuch',
    cmd = { 'Rename', 'Remove' }
  },
  { "numToStr/Comment.nvim", config = true },
  {
    'L3MON4D3/LuaSnip',
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/Code/User/snippets" } })
      vim.cmd([[
        imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
        ]])
    end
  },
  { "NvChad/nvim-colorizer.lua", config = true },
  { "kylechui/nvim-surround", config = true },
  {
    -- Use `B` command to pipe just part of a visual selection
    'vim-scripts/vis',
    cmd = "B"
  },
  { 'github/copilot.vim' },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      vim.g.catppuccin_flavour = "mocha"
      require("catppuccin").setup()
      vim.cmd [[colorscheme catppuccin]]
    end
  },
  { 'j-hui/fidget.nvim', },
  {
      'nvim-treesitter/playground',
      cmd = 'TSPlaygroundToggle'
  },
  -- Languages
  { 'dag/vim-fish', ft = { 'fish' }, }
}
