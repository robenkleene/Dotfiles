return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim", },
  keys = {
    { '<leader>b' },
    { '<leader>d' },
    { '<leader>o' },
    { '<leader>s' },
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
    vim.keymap.set('n', '<leader>d', require('telescope.builtin').diagnostics)
    vim.keymap.set('n', '<leader>o', require('telescope.builtin').oldfiles)
    vim.keymap.set('n', '<leader>s', require('telescope.builtin').lsp_document_symbols)
  end
}
