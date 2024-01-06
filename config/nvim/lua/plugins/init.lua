return {
  {
    'tpope/vim-unimpaired',
    keys = {
      "]a", "[a",
      "]b", "[b",
      "]f", "[f",
      "]l", "[l",
      "]n", "[n",
      "]q", "[q",
      "]Q", "[Q",
      "]t", "[t",
      "]T", "[T",
    },
  },
  {
    "numToStr/Comment.nvim",
    config = true,
    keys = { "gc", { "gc", mode = "v" } },
  },
  { 'tpope/vim-vinegar' },
  -- This doesn't handle visual blocks correctly
  -- { "kylechui/nvim-surround", config = true, event = "VeryLazy" },
  { 'tpope/vim-surround',
    keys = { "ys", "ds", "cs", { "S", mode = "v" } },
  },
  { 'tpope/vim-repeat' },
  {
    -- Use `B` command to pipe just part of a visual selection, e.g., `B !sort`
    'vim-scripts/vis',
    cmd = "B"
  },
  {
    'nvim-treesitter/playground',
    cmd = { 'TSPlaygroundToggle', 'TSCaptureUnderCursor' }
  },
  {
    -- More reliable open browser
    "tyru/open-browser.vim",
    keys = { "gx" },
    config = function()
        vim.cmd([[
        let g:netrw_nogx = 1
        nmap gx <Plug>(openbrowser-open)
        vmap gx <Plug>(openbrowser-open)
        ]])
    end
  },
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
  { 'dag/vim-fish', ft = { 'fish' }, }
}
