-- Good to be accustomed to not having this, because it makes it easier when
-- using implementations of Vim mode that doesn't support this (e.g., in Visual
-- Studio Code)
-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
-- local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
-- vim.api.nvim_create_autocmd('TextYankPost', {
--   callback = function()
--     vim.highlight.on_yank({ timeout = 60, on_visual = false })
--   end,
--   group = highlight_group,
--   pattern = '*',
-- })

-- This causes line breaks to be misshandled when copying lines (e.g.,
-- `yy`)
-- vim.o.clipboard = vim.o.clipboard .. "unnamedplus"

-- Always show the `signcolumn`, this prevents an issue where the text moves
-- because indicators are flapping
vim.opt.signcolumn = "yes"
