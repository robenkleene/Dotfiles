return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim", },
  keys = {
    { '<leader>b' },
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
        diagnostics = { theme = "ivy" },
        oldfiles = { theme = "ivy" },
        quickfix = { theme = "ivy" },
        quickfixhistory = { theme = "ivy" },
        lsp_document_symbols = {
          -- Add more space for the symbol
          -- symbol_width = 40,
          -- Show the line of the declaration
          theme = "ivy",
          show_line = true
        },
      }
    }
    -- Strategy here is to use a minimal number of telescope pickers, and instead have other functionality populate the `quickfix` list and then use the `quickfix` bindings to traverse
    -- E.g., don't add Telescope `lines` builtin, instead use `:vimgrep` to populate the quickfix list and then use Telescope `quickfix` to traverse the matches
    vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers)
    vim.keymap.set('n', '<leader>o', require('telescope.builtin').oldfiles)
    vim.keymap.set('n', '<leader>s', require('telescope.builtin').lsp_document_symbols)
  end
}
