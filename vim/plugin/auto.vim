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
  autocmd BufWritePost *.zsh,*.py,*.pl,*.sh,*.rb,*.swift :call auto#MakeShebangFilesExecutable()
augroup END

augroup quickfix_height
  autocmd!
  autocmd FileType qf call auto#AdjustWindowHeight(3, 20)
augroup END

augroup disable_autocomments
  autocmd!
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
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
  " Oddly, `silent! checktime` doesn't seem to update after a `git checkout
  " <file>` while just `checktime` does. (`silent! checktime` when editing the
  " same file in another `vim` instance though.)
  autocmd CursorHold,CursorHoldI,FocusGained,BufEnter * if expand('%') !=# '[Command Line]' | checktime | endif
augroup END

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
" Don't restore the current directory, this has an unpredictable effect when
" cycling through lots of files quickly, e.g., when processing the `quickfix`
" list.
set viewoptions-=curdir
" Don't restore empty buffers
set viewoptions-=blank
augroup save_view
  autocmd!
  autocmd BufWinLeave *
        \   if expand('%') != ''
        \&& &buftype !~ 'nofile'
        \&& &buftype !~ 'help'
        \&& &buftype !~ 'term'
        \&& &filetype !~ 'gitcommit'
        \&& &filetype !~ 'pullrequest'
        \&& &filetype !~ 'gitrebase'
        \|    mkview
        \|  endif
  autocmd BufWinEnter *
        \   if expand('%') != ''
        \&& &buftype !~ 'nofile'
        \&& &buftype !~ 'help'
        \&& &buftype !~ 'term'
        \&& &filetype !~ 'gitcommit'
        \&& &filetype !~ 'pullrequest'
        \&& &filetype !~ 'gitrebase'
        \|    silent! loadview
        \|  endif
augroup END

" Write directory to temp file
let s:temporary_directory = "/tmp/vim.robenkleene/"
let s:chdirectory_directory = s:temporary_directory . "chdir"
let s:chdirectory_file = s:chdirectory_directory . "/chdir"
if !isdirectory(s:chdirectory_directory)
  call mkdir(s:chdirectory_directory, 'p')
endif
function! s:isdir(dir)
  return !empty(a:dir) && (isdirectory(a:dir) ||
        \ (!empty($SYSTEMDRIVE) && isdirectory('/'.tolower($SYSTEMDRIVE[0]).a:dir)))
endfunction
augroup write_chdir
  autocmd!
  autocmd VimLeavePre *
        \ if <SID>isdir(expand('%:h'))
        \ | call writefile([expand('%:h:p')], s:chdirectory_file)
        \ | endif
augroup END

" Close the quickfix if it's the last window
augroup close_quickfix
  autocmd!
  autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
augroup END
