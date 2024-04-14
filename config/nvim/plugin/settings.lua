-- Good to be accustomed to not having this, because it makes it easier when
-- using implementations of Vim mode that doesn't support this (e.g., in Visual
-- Studio Code)
-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ higroup="Visual", timeout = 180, on_visual = false })
  end
})

-- Always show the `signcolumn`, this prevents an issue where the text moves
-- because indicators are flapping
vim.opt.signcolumn = "yes"
