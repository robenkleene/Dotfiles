return {
  'ibhagwan/fzf-lua',
  keys = {
    { '<leader>D' },
    { '<leader>S' },
    { '<leader>T' },
    { '<leader>d' },
    { '<leader>f' },
    { '<leader>s' },
    { '<leader>t' },
  },
  config = function()
    require('fzf-lua').setup({})
    vim.cmd([[
    nnoremap <silent> <leader>D :lua require("fzf-lua").diagnostics_workspace()<cr>
    nnoremap <silent> <leader>S :lua require("fzf-lua").lsp_workspace_symbols()<cr>
    nnoremap <silent> <leader>T :lua require("fzf-lua").tags()<cr>
    nnoremap <silent> <leader>d :lua require("fzf-lua").diagnostics_document()<cr>
    nnoremap <silent> <leader>f :lua require("fzf-lua").files()<cr>
    nnoremap <silent> <leader>s :lua require("fzf-lua").lsp_document_symbols()<cr>
    nnoremap <silent> <leader>t :lua require("fzf-lua").btags()<cr>
    ]])
  end
}
