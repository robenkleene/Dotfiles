require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

pcall(require('telescope').load_extension, 'fzf')

vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers)
vim.keymap.set('n', '<leader>l', require('telescope.builtin').current_buffer_fuzzy_find)
vim.keymap.set('n', '<leader>F', require('telescope.builtin').find_files)
vim.keymap.set('n', '<leader>/', require('telescope.builtin').live_grep)
