return {
  'junegunn/fzf.vim',
  dependencies = {
    { 'junegunn/fzf', },
  },
  keys = {
    { '<leader>b' },
    { '<leader>f' },
    { '<leader>g' },
    { '<leader>o' },
    { '<leader>t' },
  },
  config = function()
    vim.cmd([[
    set rtp+=$HOMEBREW_DIR/opt/fzf

    " Use fzf for buffers and old files because it supports disabling sorting
    " for old files, and using `^<prefix>` or `<postfix>$` searches, which are
    " particularly helpful for specifying a file type for old files
    nnoremap <silent> <leader>b :Buffers<CR>
    " `:Files` is useful because it doesn't require `fd` to finish executing,
    " like the `Fd:` command, which means it's usually faster
    nnoremap <silent> <leader>f :Files<CR>
    " `:Files` and `:RG` are particularly useful when editing in directories of
    " text files
    nnoremap <silent> <leader>g :RG<CR>
    nnoremap <silent> <leader>o :FzfOldfiles<CR>
    nnoremap <silent> <leader>t :BTags<CR>

    " Don't sort old files
    command! -bang -nargs=* FzfOldfiles call fzf#vim#history(fzf#vim#with_preview({'options': '--no-sort'}))
    ]])
  end
}
