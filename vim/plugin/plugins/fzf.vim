set rtp+=$HOMEBREW_DIR/opt/fzf

nnoremap <leader>b :Buffers<CR>
nnoremap <leader>l :BLines<CR>
nnoremap <leader>r :History<CR>
nnoremap <leader>s :RG<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>m :Marks<CR>
nnoremap <leader>i :BTags<CR>
nnoremap <leader>I :Tags<CR>

nnoremap <M-z> :Z<CR>

function! s:cd_sink(e) abort
  call s:file_manager(a:e)
  " execute 'Explore' a:e
  let l:path = expand('%')
  if !empty(l:path)
    " This should be an `lcd` but that doesn't work reliably
    " cd %
    lcd %
  endif
endfunction

function! s:file_manager(directory) abort
  if exists(':Dirvish')
    execute 'Dirvish' a:directory
  else
    execute 'Explore' a:directory
  endif
endfunction

command! Z :call fzf#run(fzf#wrap({
      \   'source': "zoxide query --list",
      \   'sink': function('<SID>cd_sink')
      \ }))
