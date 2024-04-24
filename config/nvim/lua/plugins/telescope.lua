return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim", },
  keys = {
    { '<leader>s' },
  },
  config = function()
    require('telescope').setup {
      pickers = {
        lsp_document_symbols = {
          -- Add more space for the symbol
          -- symbol_width = 40,
          -- Show the line of the declaration
          theme = "ivy",
          show_line = true
        },
      }
    }
    vim.keymap.set('n', '<leader>s', require('telescope.builtin').lsp_document_symbols)
  end
}
