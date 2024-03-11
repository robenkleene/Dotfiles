return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim", },
  keys = {
    { '<leader>d' },
  },
  config = function()
    require('telescope').setup { }
    vim.keymap.set('n', '<leader>d', require('telescope.builtin').diagnostics)
  end
}
