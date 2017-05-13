nnoremap <silent> G :set opfunc=<SID>Google<CR>g@
vnoremap <silent> G :<C-U>call <SID>Google(visualmode(), 1)<CR>

function! s:Google(type, ...) abort
  let sel_save = &selection
  let &selection = "inclusive"
  let reg_save = @@

  if a:0  " Invoked from Visual mode, use gv command.
    silent exe "normal! gvy"
  elseif a:type == 'line'
    silent exe "normal! '[V']y"
  else
    silent exe "normal! `[v`]y"
  endif

  let escaped=substitute(@@,'[^A-Za-z0-9_.~-]','\="%".printf("%02X",char2nr(submatch(0)))','g')
  let googleurl="http://www.google.com/search?q=" . escaped
  silent exec "!open '".googleurl."'"

  let &selection = sel_save
  let @@ = reg_save
endfunction
