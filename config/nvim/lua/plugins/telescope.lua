return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim", },
  keys = {
    { '<leader>d' },
    { '<leader>s' },
  },
  config = function()
    require('telescope').setup {
      pickers = {
        lsp_document_symbols = {
          -- Add more space for the symbol
          -- symbol_width = 40,
          -- Show the line of the declaration
          show_line = true,
          -- The `ivy` theme has the search field at the top (instead of the
          -- bottom), which means the results afterwords are then sorted in the
          -- correct order (i.e., the same order as the file). With the default
          -- picker, the sort order is inverted with the search filter at the
          -- bottom
          theme = 'ivy'
        }
      }
    }
    vim.keymap.set('n', '<leader>d', require('telescope.builtin').diagnostics)
    vim.keymap.set('n', '<leader>s', require('telescope.builtin').lsp_document_symbols)
  end
}
