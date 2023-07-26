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
    { '<leader>f' },
    -- { '<leader>F' },
    { '<leader>g' },
    -- { '<leader>S' },
    { '<leader>i' },
    { '<leader>I' },
    { '<leader>r' },
    { '<leader>m' },
    { '<leader>d' },
  },
  config = function()
    pcall(require('telescope').load_extension, 'fzf')
    require('telescope').setup{
      defaults = {
        mappings = {
          i = {
            ["<C-p>"] = require('telescope.actions').cycle_history_prev,
            ["<C-n>"] = require('telescope.actions').cycle_history_next,
            ["<M-p>"] = require('telescope.actions').cycle_history_prev,
            ["<M-n>"] = require('telescope.actions').cycle_history_next,
            ["<M-Up>"] = require('telescope.actions').cycle_history_prev,
            ["<M-Down>"] = require('telescope.actions').cycle_history_next,
          },
        }
      },
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
    -- vim.keymap.set('n', '<leader>f', '<cmd>lua require("telescope.builtin").find_files({cwd = "%:h"})<CR>')
    -- vim.keymap.set('n', '<leader>F', require('telescope.builtin').find_files)
    -- vim.keymap.set('n', '<leader>s', '<cmd>lua require("telescope.builtin").live_grep({cwd = "%:h"})<CR>')
    -- vim.keymap.set('n', '<leader>S', require('telescope.builtin').live_grep)
    vim.keymap.set('n', '<leader>g', require('telescope.builtin').live_grep)
    vim.keymap.set('n', '<leader>f', require('telescope.builtin').find_files)
    vim.keymap.set('n', '<leader>i', require('telescope.builtin').lsp_document_symbols)
    vim.keymap.set('n', '<leader>I', require('telescope.builtin').lsp_dynamic_workspace_symbols)
    vim.keymap.set('n', '<leader>r', require('telescope.builtin').oldfiles)
    vim.keymap.set('n', '<leader>m', require('telescope.builtin').marks)
    vim.keymap.set('n', '<leader>d', require('telescope.builtin').diagnostics)
  end
}
