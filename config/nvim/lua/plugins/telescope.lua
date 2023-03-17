return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
    config = true,
  },
  keys = {
    { '<leader>b' },
    { '<leader>l' },
    { '<leader>F' },
    { '<leader>f' },
    { '<leader>/' },
    { '<leader>s' },
    { '<leader>S' },
    { '<M-c>' },
    { '<M-z>' },
    { '<M-o>' },
  },
  config = function()
    pcall(require('telescope').load_extension, 'fzf')
    require('telescope').setup{
      pickers = {
        find_files = { theme = "dropdown" },
        buffers = { theme = "dropdown" },
        current_buffer_fuzzy_find = { theme = "dropdown" },
        live_grep = { theme = "dropdown" },
        lsp_document_symbols = { theme = "dropdown" },
        lsp_dynamic_workspace_symbols = { theme = "dropdown" }
      }
    }
    vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers)
    vim.keymap.set('n', '<leader>l', require('telescope.builtin').current_buffer_fuzzy_find)
    vim.keymap.set('n', '<leader>F', require('telescope.builtin').find_files)
    vim.keymap.set('n', '<leader>f', require('telescope.builtin').find_files)
    vim.keymap.set('n', '<leader>/', require('telescope.builtin').live_grep)
    vim.keymap.set('n', '<leader>s', require('telescope.builtin').lsp_document_symbols)
    vim.keymap.set('n', '<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)
    vim.keymap.set('n', '<M-c>', ":Telescope find_files find_command=z_list_subdir<CR>")
    vim.keymap.set('n', '<M-z>', ":Telescope find_files find_command=z_list<CR>")
    vim.keymap.set('n', '<M-o>', ":Telescope find_files find_command=find_ls<CR>")
  end
}
