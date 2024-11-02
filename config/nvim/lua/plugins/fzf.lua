return {
  'ibhagwan/fzf-lua',
  keys = {
    { '<leader>S' },
    { '<leader>T' },
    { '<leader>s' },
    { '<leader>t' },
  },
  config = function()
    require('fzf-lua').setup({})
    vim.cmd([[
    nnoremap <silent> <leader>S :lua require("fzf-lua").lsp_workspace_symbols()<cr>
    nnoremap <silent> <leader>T :lua require("fzf-lua").tags()<cr>
    nnoremap <silent> <leader>s :lua require("fzf-lua").lsp_document_symbols()<cr>
    nnoremap <silent> <leader>t :lua require("fzf-lua").btags()<cr>
    ]])
  end
}
