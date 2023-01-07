return {
  { "gpanders/editorconfig.nvim", event = "VeryLazy" },
  {
    "elihunter173/dirbuf.nvim",
    -- This breaks `nvim .`
    -- keys = {
    --   { '-' },
    -- },
    config = function()
      require("dirbuf").setup {
        show_hidden = false,
      }
    end
  },
  {
    'tpope/vim-eunuch',
    cmd = { 'Rename', 'Remove' }
  },
  { "numToStr/Comment.nvim", config = true, event = "VeryLazy" },
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
        {expr = true, silent = true})
    end
  },
  { 'github/copilot.vim', event = "VeryLazy", },
  { "NvChad/nvim-colorizer.lua", config = true, event = "VeryLazy" },
  { "kylechui/nvim-surround", config = true, event = "VeryLazy" },
  {
    -- Use `B` command to pipe just part of a visual selection
    'vim-scripts/vis',
    cmd = "B"
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup()
      vim.cmd("colorscheme catppuccin")
    end
  },
  {
      'nvim-treesitter/playground',
      cmd = 'TSPlaygroundToggle'
  },
  -- Languages
  { 'dag/vim-fish', ft = { 'fish' }, }
}
