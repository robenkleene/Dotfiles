return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
    config = true,
    keys = {
      { '<leader>b', require('telescope.builtin').buffers, },
      { '<leader>l', require('telescope.builtin').current_buffer_fuzzy_find, },
      { '<leader>F', require('telescope.builtin').find_files, },
      { '<leader>f', require('telescope.builtin').find_files, },
      { '<leader>/', require('telescope.builtin').live_grep, },
      { '<leader>s', require('telescope.builtin').lsp_document_symbols, },
      { '<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols, },
    },
  },
  config = function()
    pcall(require('telescope').load_extension, 'fzf')
  end
}
