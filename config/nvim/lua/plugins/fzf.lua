return {
  'ibhagwan/fzf-lua',
  keys = {
    { '<leader>b' },
    { '<leader>g' },
    { '<leader>o' },
    { '<leader>f' },
    { '<leader>t' },
    { '<leader>d' },
    { '<leader>s' },
  },
  config = function()
    require('fzf-lua').setup({})
    vim.cmd([[
    nnoremap <silent> <leader>b :lua require("fzf-lua").buffers()<cr>
    nnoremap <silent> <leader>d :lua require("fzf-lua").diagnostics_workspace()<cr>
    nnoremap <silent> <leader>f :lua require("fzf-lua").files()<cr>
    nnoremap <silent> <leader>g :lua require("fzf-lua").live_grep()<cr>
    nnoremap <silent> <leader>o :lua require("fzf-lua").oldfiles()<cr>
    nnoremap <silent> <leader>s :lua require("fzf-lua").lsp_document_symbols()<cr>
    ]])
  end
}
