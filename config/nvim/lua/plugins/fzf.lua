return {
  'junegunn/fzf.vim',
  dependencies = {
    { 'junegunn/fzf', },
  },
  keys = {
    { '<leader>b' },
    { '<leader>l' },
    { '<leader>o' },
    { '<leader>t' },
  },
  config = function()
    vim.cmd([[
    set rtp+=$HOMEBREW_DIR/opt/fzf

    nnoremap <silent> <leader>b :Buffers<CR>
    nnoremap <silent> <leader>l :BLines<CR>
    nnoremap <silent> <leader>o :FZFHistory<CR>
    nnoremap <silent> <leader>t :BTags<CR>

    command! -bang -nargs=* FZFHistory call fzf#vim#history(fzf#vim#with_preview({'options': '--no-sort'}))
    ]])
  end
}
