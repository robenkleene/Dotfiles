return {
  'ibhagwan/fzf-lua',
  keys = {
    { '<leader>D' },
    { '<leader>S' },
    { '<leader>T' },
    { '<leader>b' },
    { '<leader>d' },
    { '<leader>f' },
    { '<leader>g' },
    { '<leader>o' },
    { '<leader>q' },
    { '<leader>s' },
    { '<leader>t' },
  },
  config = function()
    require('fzf-lua').setup({})
    vim.cmd([[
    nnoremap <silent> <leader>D :lua require("fzf-lua").diagnostics_workspace()<cr>
    nnoremap <silent> <leader>S :lua require("fzf-lua").lsp_workspace_symbols()<cr>
    nnoremap <silent> <leader>T :lua require("fzf-lua").tags()<cr>
    nnoremap <silent> <leader>b :lua require("fzf-lua").buffers()<cr>
    nnoremap <silent> <leader>d :lua require("fzf-lua").diagnostics_document()<cr>
    nnoremap <silent> <leader>f :lua require("fzf-lua").files()<cr>
    nnoremap <silent> <leader>g :lua require("fzf-lua").live_grep()<cr>
    nnoremap <silent> <leader>o :lua require("fzf-lua").oldfiles()<cr>
    nnoremap <silent> <leader>q :lua require("fzf-lua").quickfix()<cr>
    nnoremap <silent> <leader>s :lua require("fzf-lua").lsp_document_symbols()<cr>
    nnoremap <silent> <leader>t :lua require("fzf-lua").btags()<cr>
    nnoremap <silent> <leader>t :lua require("fzf-lua").btags()<cr>
    ]])
  end
}
