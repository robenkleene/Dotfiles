return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim", },
  keys = {
    { '<leader>s' },
    { '<leader>c' },
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
        quickfix = { theme = "ivy", },
      }
    }
    vim.keymap.set('n', '<leader>s', require('telescope.builtin').lsp_document_symbols)
    vim.keymap.set('n', '<leader>c', require('telescope.builtin').quickfix)
  end
}
