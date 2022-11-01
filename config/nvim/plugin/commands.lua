vim.api.nvim_create_user_command('Format',
  function()
    vim.lsp.buf.format { async = true }
  end,
  { nargs = 0, desc = 'Format' }
)
