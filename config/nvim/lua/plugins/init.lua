return {
  { 'tpope/vim-unimpaired', },
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
  { "github/copilot.vim" },
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
  -- Languages
  { 'dag/vim-fish', ft = { 'fish' }, },
  { 'sophacles/vim-processing', ft = { 'processing' }, }
}
