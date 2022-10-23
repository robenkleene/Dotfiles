-- Start message
vim.o.shortmess = vim.o.shortmess .. "I"

-- Line numbers
vim.wo.number = true

-- Indent wrapped lines
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true
vim.cmd [[colorscheme catppuccin]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Automatically use system clipboard
vim.o.clipboard = vim.o.clipboard .. "unnamedplus"

vim.cmd([[
" For state restoration
set sessionoptions-=options
set sessionoptions-=folds
set sessionoptions-=blank
set iskeyword+=-
set splitbelow
set splitright
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set list
" Autocomplete max height
set pumheight=10
" Disable swap files, this allows multiple instances to edit the same file
set noswapfile
]])
