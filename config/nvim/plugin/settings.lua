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
    vim.highlight.on_yank({ timeout = 60, on_visual = false })
  end,
  group = highlight_group,
  pattern = '*',
})

-- Use system clipboard
-- Delibrately ommitted because the custom clipboard `augroup` handles the
-- clipboard (and also supports `tmux`). Also having this causes line breaks to
-- be misshandled when copying lines (e.g., `yy`)
-- vim.o.clipboard = vim.o.clipboard .. "unnamedplus"
