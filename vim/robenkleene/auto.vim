augroup save_session
  autocmd!
  autocmd VimLeave * mksession! ~/.vim/vim_auto_session
augroup END

" Make completion case-sensitive
" (While still allowing search to be case-insensitive)
augroup ignore_case_in_insert
  autocmd!
  autocmd InsertEnter * setlocal noignorecase
  autocmd InsertLeave * setlocal ignorecase
augroup END

" Make Shebang Files Executable
function! s:MakeShebangFilesExecutable() abort
  if match(getline(1), '^\#!') == 0
    if match(getfperm(expand('%:p')), 'x') == -1
      !chmod +x %
    endif
  endif
endfunction
augroup executable_files
  autocmd!
  autocmd BufWritePost *.pl,*.sh,*.rb,*.fish :call <SID>MakeShebangFilesExecutable()
augroup END

augroup quickfix_height
  autocmd!
  autocmd FileType qf call <SID>AdjustWindowHeight(3, 20)
augroup END
function! s:AdjustWindowHeight(minheight, maxheight) abort
  execute max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
  execute "normal! \<C-w>="
endfunction

" Highlight cursor line
" set cursorline
" Show cursorline only in active window
augroup cursor_line_active_window
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  " Don't leave disable nocursorline, otherwise the current line won't be 
  " highlighted when using the `quickfix` list
  " autocmd WinLeave * setlocal nocursorline
augroup END

" Disable Cursor Line in Insert Mode
augroup disable_cursor_line
  autocmd!
  autocmd InsertEnter * setlocal nocursorline
  autocmd InsertLeave * setlocal cursorline
augroup END

" Fix quickfix colors
augroup quickfix_colors
  autocmd!
  " These interfere with the selected line being highlighted in quickfix
  " windows
  autocmd VimEnter,WinEnter,BufWinEnter * if &buftype == 'quickfix' | setlocal nocursorline | endif
  autocmd WinEnter,BufWinEnter * if &buftype == 'quickfix' | setlocal colorcolumn="" | endif
augroup END

" Autoreload files edited by other programs
set autoread
augroup reload_buffers
  autocmd!
  autocmd CursorHold,CursorHoldI,FocusGained,BufEnter * checktime
augroup END
" This makes it so hitting `<c-z>` then changing a file then `fg` to return
" will update instantly.
noremap <c-z> :suspend<cr>:silent! checktime<cr>

augroup setup_netrw
  autocmd!
  autocmd FileType netrw call <SID>setup_netrw()
augroup END
function! s:fnameescape(file) abort
  if exists('*fnameescape')
    return fnameescape(a:file)
  else
    return escape(a:file," \t\n*?[{`$\\%#'\"|!<")
  endif
endfunction
function! s:setup_netrw() abort
  " This conflicts with `gcc` for `commentary` so it causes a delay
  nnoremap <buffer> <silent> gc :exe 'keepjumps cd ' .<SID>fnameescape(b:netrw_curdir)<CR>
endfunction
