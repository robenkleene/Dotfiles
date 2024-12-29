return {
  'ibhagwan/fzf-lua',
  keys = {
    { '<leader>S' },
    { '<leader>T' },
    { '<leader>b' },
    { '<leader>o' },
    { '<leader>s' },
    { '<leader>t' },
  },
  config = function()
    require('fzf-lua').setup({})
    vim.cmd([[
    nnoremap <silent> <leader>S :lua require("fzf-lua").lsp_workspace_symbols()<cr>
    nnoremap <silent> <leader>T :lua require("fzf-lua").tags()<cr>
    nnoremap <silent> <leader>b :lua require("fzf-lua").buffers()<cr>
    nnoremap <silent> <leader>o :lua require("fzf-lua").oldfiles()<cr>
    nnoremap <silent> <leader>s :lua require("fzf-lua").lsp_document_symbols()<cr>
    nnoremap <silent> <leader>t :lua require("fzf-lua").btags()<cr>
    ]])
  end
}
