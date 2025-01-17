return {
  { 'tpope/vim-unimpaired' },
  -- Vinegar doesn't seem to properly select the current file with `-`
  { 'tpope/vim-vinegar' },
  -- This doesn't handle visual blocks correctly
  -- { "kylechui/nvim-surround", config = true, event = "VeryLazy" },
  {
    'tpope/vim-surround',
    keys = { "ys", "ds", "cs", { "S", mode = "v" } },
  },
  { 'tpope/vim-repeat' },
  { 'robenkleene/partshell.vim' },
  {
    -- The built in `:Man` command doesn't support completion well
    'vim-utils/vim-man',
    cmd = { 'Man' },
  },
}
