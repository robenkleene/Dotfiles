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
      { '<leader>b' },
      { '<leader>l' },
      { '<leader>F' },
      { '<leader>f' },
      { '<leader>/' },
      { '<leader>s' },
      { '<leader>S' },
    },
  },
  config = function()
    pcall(require('telescope').load_extension, 'fzf')
    vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers)
    vim.keymap.set('n', '<leader>l', require('telescope.builtin').current_buffer_fuzzy_find)
    vim.keymap.set('n', '<leader>F', require('telescope.builtin').find_files)
    vim.keymap.set('n', '<leader>f', require('telescope.builtin').find_files)
    vim.keymap.set('n', '<leader>/', require('telescope.builtin').live_grep)
    vim.keymap.set('n', '<leader>s', require('telescope.builtin').lsp_document_symbols)
    vim.keymap.set('n', '<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)
  end
}
