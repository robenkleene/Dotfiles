-- Start message
vim.o.shortmess = vim.o.shortmess .. "I"

-- Line numbers
vim.wo.number = true

-- Indent wrapped lines
vim.o.breakindent = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ timeout = 50, on_visual = false })
  end,
  group = highlight_group,
  pattern = '*',
})

-- Use system clipboard
vim.o.clipboard = vim.o.clipboard .. "unnamedplus"
