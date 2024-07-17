return {
  { 'tpope/vim-unimpaired', },
  -- Vinegar doesn't seem to properly select the current file with `-`
  -- { 'tpope/vim-vinegar' },
  {
    'stevearc/oil.nvim',
    config = function()
      require("oil").setup({
        keymaps = {
          ["~"] = { "actions.cd", opts = { scope = "win" }, desc = ":lcd to the current oil directory" },
        },
        skip_confirm_for_simple_edits = true,
        watch_for_changes = true
      })
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end
  },
  -- This doesn't handle visual blocks correctly
  -- { "kylechui/nvim-surround", config = true, event = "VeryLazy" },
  {
    'tpope/vim-surround',
    keys = { "ys", "ds", "cs", { "S", mode = "v" } },
  },
  { 'tpope/vim-repeat' },
  -- Themes
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   config = function()
  --     require("catppuccin").setup()
  --     vim.cmd("colorscheme catppuccin")
  --   end
  -- },
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   event = "VeryLazy",
  --   opts = function()
  --     return { theme = 'tokyonight' }
  --   end,
  -- },
  {
    "folke/tokyonight.nvim",
    -- Don't set this here because then override colors `autocmd` will trigger
    -- too late
    -- config = function()
    --   vim.cmd("colorscheme tokyonight-night")
    -- end
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
}
