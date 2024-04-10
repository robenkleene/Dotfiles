return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim", },
  keys = {
    { '<leader>b' },
    { '<leader>o' },
    { '<leader>s' },
    { '<leader>c' },
    { '<leader>C' },
  },
  config = function()
    require('telescope').setup {
      defaults = {
        -- Always make filename visible, e.g., if a path is long, don't cut it off
        path_display = {
          "smart"
        },
      },
      pickers = {
        buffers = { theme = "ivy" },
        current_buffer_fuzzy_find = { theme = "ivy" },
        lsp_document_symbols = {
          -- Add more space for the symbol
          -- symbol_width = 40,
          -- Show the line of the declaration
          theme = "ivy",
          show_line = true
        },
        diagnostics = { theme = "ivy" },
        oldfiles = { theme = "ivy" },
      }
    }
    vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers)
    vim.keymap.set('n', '<leader>o', require('telescope.builtin').oldfiles)
    vim.keymap.set('n', '<leader>s', require('telescope.builtin').lsp_document_symbols)
    vim.keymap.set('n', '<leader>c', require('telescope.builtin').quickfix)
    vim.keymap.set('n', '<leader>C', require('telescope.builtin').quickfixhistory)
  end
}
