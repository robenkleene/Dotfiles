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
augroup executable_files
  autocmd!
  autocmd BufWritePost *.pl,*.sh,*.rb,*.fish :call auto#MakeShebangFilesExecutable()
augroup END

augroup quickfix_height
  autocmd!
  autocmd FileType qf call auto#AdjustWindowHeight(3, 20)
augroup END

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
  " This line causes all `BufWinEnter` `autocmd` to fail!?
  " autocmd WinEnter,BufWinEnter * if &buftype == 'quickfix' | setlocal colorcolumn="" | endif
augroup END

" Autoreload files edited by other programs
set autoread
augroup reload_buffers
  autocmd!
  autocmd CursorHold,CursorHoldI,FocusGained,BufEnter * if expand('%') !=# '[Command Line]' | silent checktime | endif
augroup END
" This makes it so hitting `<c-z>` then changing a file then `fg` to return
" will update instantly.
noremap <c-z> :suspend<cr>:silent checktime<cr>

augroup setup_netrw
  autocmd!
  autocmd FileType netrw call auto#setup_netrw()
augroup END

" Automatically save and restore metadata like cursor position
" This prevents the working directory from being saved as part of the view
" options, which is confusing when opening an old file where the working
" directory may have been different.
" Match this to `sessionoptions`
set viewoptions-=options
" Saving and restoring folds is completely unpredictable
set viewoptions-=folds
augroup save_view
  autocmd!
  autocmd BufWinLeave *
        \   if expand('%') != ''
        \&& &buftype !~ 'nofile'
        \&& &buftype !~ 'help'
        \&& &buftype !~ 'term'
        \&& &filetype !~ 'gitcommit'
        \&& &filetype !~ 'gitrebase'
        \|    mkview
        \|  endif
  autocmd BufWinEnter *
        \   if expand('%') != ''
        \&& &buftype !~ 'nofile'
        \&& &buftype !~ 'help'
        \&& &buftype !~ 'term'
        \&& &filetype !~ 'gitcommit'
        \&& &filetype !~ 'gitrebase'
        \|    silent! loadview
        \|  endif
augroup END
