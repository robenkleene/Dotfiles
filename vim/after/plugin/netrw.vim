augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call s:NetrwMapping()
augroup END

" Override Netrw's own bindings
function! s:NetrwMapping()
  nnoremap <buffer> <silent> <S-Left> :TmuxNavigateLeft<cr>
  nnoremap <buffer> <silent> <S-Down> :TmuxNavigateDown<cr>
  nnoremap <buffer> <silent> <S-Up> :TmuxNavigateUp<cr>
  nnoremap <buffer> <silent> <S-Right> :TmuxNavigateRight<cr>
endfunction

" Disable netrw's built-in support
autocmd! Network BufReadCmd file://*
augroup follow_file_links
  autocmd!
  " autocmd BufReadCmd file:///* call s:OpenFileURL()
  autocmd BufNewFile file:///* call s:OpenFileURL()
augroup END



function! s:OpenFileURL()
  let edit_command = "edit /" . substitute(expand("<afile>"),"file:/*","","")
  execute edit_command
  " Delete the `file:///` buffer
  execute "bd#"
  
  " Restore Syntax Highlighting
  execute "filetype detect"
endfunction

