return {
  { 'tpope/vim-unimpaired', },
  {
    'tpope/vim-commentary',
    -- This prevents the `autocmd` from firing
    -- keys = { "gc", { "gc", mode = "v" } },
    config = function()
      vim.cmd([[
      map  gc  <Plug>Commentary
      nmap gcc <Plug>CommentaryLine
      " Suppress the extra space after `//` for processing files
      " Without `b:commentary_format` commentary adds this by default
      augroup commentary_format
        autocmd!
        autocmd FileType processing :let b:commentary_format = &commentstring
      augroup END
      ]])
    end
  },
  { 'tpope/vim-vinegar' },
  { 'tpope/vim-rsi' },
  -- This doesn't handle visual blocks correctly
  -- { "kylechui/nvim-surround", config = true, event = "VeryLazy" },
  {
    'tpope/vim-surround',
    keys = { "ys", "ds", "cs", { "S", mode = "v" } },
  },
  { 'tpope/vim-repeat' },
  {
    'nvim-treesitter/playground',
    cmd = { 'TSPlaygroundToggle', 'TSCaptureUnderCursor' }
  },
  {
    -- More reliable open browser
    'tyru/open-browser.vim',
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
