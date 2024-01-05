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
    { '<leader>g' },
    { '<leader>r' },
    { '<localleader>D' },
    { '<localleader>i' },
    { '<localleader>I' },
    { '<localleader>R' },
  },
  config = function()
    pcall(require('telescope').load_extension, 'fzf')
    require('telescope').setup {
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
        -- Good themes are `ivy` and `dropdown`. `dropdown` makes good use of vertical space (but not horizontal), `ivy` makes good use of both vertical and horizontal space
        buffers = { theme = "ivy" },
        current_buffer_fuzzy_find = { theme = "ivy" },
        find_files = { theme = "ivy", follow = true },
        live_grep = { additional_args = { theme = "ivy", "--follow" } },
        lsp_document_symbols = {
          -- Add more space for the symbol
          -- symbol_width = 40,
          -- Show the line of the declaration
          theme = "ivy",
          show_line = true
        },
        lsp_dynamic_workspace_symbols = { theme = "ivy" },
        lsp_references = { theme = "ivy" },
        diagnostics = { theme = "ivy" },
      }
    }
    vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers)
    vim.keymap.set('n', '<leader>l', require('telescope.builtin').current_buffer_fuzzy_find)
    -- vim.keymap.set('n', '<leader>f', '<cmd>lua require("telescope.builtin").find_files({cwd = "%:h"})<CR>')
    -- vim.keymap.set('n', '<leader>s', '<cmd>lua require("telescope.builtin").live_grep({cwd = "%:h"})<CR>')
    vim.keymap.set('n', '<leader>g', require('telescope.builtin').live_grep)
    vim.keymap.set('n', '<leader>f', require('telescope.builtin').find_files)
    vim.keymap.set('n', '<leader>r', require('telescope.builtin').oldfiles)
    vim.keymap.set('n', '<localleader>D', require('telescope.builtin').diagnostics)
    vim.keymap.set('n', '<localleader>i', require('telescope.builtin').lsp_document_symbols)
    vim.keymap.set('n', '<localleader>I', require('telescope.builtin').lsp_dynamic_workspace_symbols)
    vim.keymap.set('n', '<localleader>R', require('telescope.builtin').lsp_references)
  end
}
