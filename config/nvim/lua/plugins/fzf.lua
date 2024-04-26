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
    { '<leader>f' },
    { '<leader>l' },
    { '<leader>o' },
    { '<leader>t' },
  },
  config = function()
    vim.cmd([[
    set rtp+=$HOMEBREW_DIR/opt/fzf

    nnoremap <silent> <leader>b :Buffers<CR>
    nnoremap <silent> <leader>f :Files<CR>
    nnoremap <silent> <leader>l :BLines<CR>
    nnoremap <silent> <leader>o :FzfOldfiles<CR>
    nnoremap <silent> <leader>t :BTags<CR>

    " Don't sort old files
    command! -bang -nargs=* FzfOldfiles call fzf#vim#history(fzf#vim#with_preview({'options': '--no-sort'}))
    " `Rg` version that doesn't shell escape so flags can be used
    command! -bang -nargs=* FzfRg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case " .
                \ <q-args>, fzf#vim#with_preview(), <bang>0)
    ]])
  end
}
