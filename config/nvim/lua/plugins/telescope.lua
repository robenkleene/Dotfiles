return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim", },
  keys = {
    { '<leader>b' },
    { '<leader>d' },
    { '<leader>s' },
    { '<leader>t' },
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
        buffers = { theme = "ivy" },
      }
    }
    vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers)
    vim.keymap.set('n', '<leader>d', require('telescope.builtin').diagnostics)
    vim.keymap.set('n', '<leader>s', require('telescope.builtin').lsp_document_symbols)
    vim.keymap.set('n', '<leader>t', require('telescope.builtin').current_buffer_tags)
  end
}
