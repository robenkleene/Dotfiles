augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call s:NetrwMapping()
augroup END

" Override Netrw's own bindings
function! s:NetrwMapping()
  noremap <silent> <S-Left> <C-w>h
  noremap <silent> <S-Down> <C-w>j
  noremap <silent> <S-Up> <C-w>k
  noremap <silent> <S-Right> <C-w>l
endfunction

" Handle `file:///` URLs
" Disable netrw's built-in support
autocmd! Network BufReadCmd file://*
augroup follow_file_links
  autocmd!
  autocmd BufNewFile file:///* call s:OpenFileURL()
augroup END

function! s:url_decode(str)
  let str = substitute(substitute(substitute(a:str,'%0[Aa]\n$','%0A',''),'%0[Aa]','\n','g'),'+',' ','g')
  return substitute(str,'%\(\x\x\)','\=nr2char("0x".submatch(1))','g')
endfunction

function! s:OpenFileURL()
  let l:file_path = "/" . substitute(expand("<afile>"),"file:/*","","")
  " Decode URL
  let l:decoded_file_path = s:url_decode(file_path)
  let l:edit_command = "edit " . fnameescape(decoded_file_path)
  " Jump back to the file so the jump list is less blocked
  execute "b#"
  " Delete the `file:///` buffer
  execute "bd#"
  " Open the correct file
  execute l:edit_command
  " Restore Syntax Highlighting
  execute "filetype detect"
endfunction
