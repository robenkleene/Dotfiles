return {
  'junegunn/fzf.vim',
  dependencies = {
    { 'junegunn/fzf', },
  },
  cmd = {
    "FzfRg"
  },
  keys = {
    { '<leader>b' },
    { '<leader>o' },
  },
  config = function()
    vim.cmd([[
    set rtp+=$HOMEBREW_DIR/opt/fzf

    nnoremap <silent> <leader>b :Buffers<CR>
    nnoremap <silent> <leader>o :FzfOldfiles<CR>

    " Don't sort old files
    command! -bang -nargs=* FzfOldfiles call fzf#vim#history(fzf#vim#with_preview({'options': '--no-sort'}))
    ]])
  end
}
