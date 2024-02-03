" Exclude buffers from restoring view settings
augroup save_view
  autocmd!
  autocmd BufWinLeave *
  \   if expand('%') != ''
  \&& &buftype !~ 'nofile'
  \&& &buftype !~ 'help'
  \&& &buftype !~ 'term'
  \&& &filetype !~ 'gitcommit'
  \&& &filetype !~ 'hgcommit'
  \&& &filetype !~ 'pullrequest'
  \&& &filetype !~ 'gitrebase'
  \|    silent! mkview
  \|  endif
  autocmd BufWinEnter *
  \   if expand('%') != ''
  \&& &buftype !~ 'nofile'
  \&& &buftype !~ 'help'
  \&& &buftype !~ 'term'
  \&& &filetype !~ 'gitcommit'
  \&& &filetype !~ 'hgcommit'
  \&& &filetype !~ 'pullrequest'
  \&& &filetype !~ 'gitrebase'
  \|    silent! loadview
  \|  endif
augroup END

" Disabling this, just use `mks[session]!` to save, and `vim -S` to load,
" which is more foolproof
" Also opening `vim` then using `'0` to go to the most recent file gets most
" of the way there alone
" augroup auto_save_session
"   autocmd!
"   autocmd VimLeave * 
"   \ if expand('%:p') !~ '^/tmp'
"   \&& len(v:this_session) == 0
"   \&& &filetype !~ 'gitcommit'
"   \&& &filetype !~ 'pullrequest'
"   \&& &filetype !~ 'gitrebase'
"   \&& &filetype !~ 'hgcommit'
"   \|    silent! mksession! ~/.vim/vim_auto_session
"   \|  endif
" augroup END

augroup executable_files
  autocmd!
  autocmd BufWritePost *.zsh,*.py,*.pl,*.sh,*.rb,*.swift :call auto#MakeShebangFilesExecutable()
augroup END

" Autoreload files edited by other programs
set autoread
" This causes a delay when opening the command-line window with `<C-f>`?
" Maybe `set autoread` is enough?
" augroup reload_buffers
"   autocmd!
"   " Oddly, `silent! checktime` doesn't seem to update after a `git checkout
"   " <file>` while just `checktime` does. (`silent! checktime` when editing the
"   " same file in another `vim` instance though.)
"   " autocmd CursorHold,CursorHoldI,FocusGained,BufEnter * if expand('%') !=# '[Command Line]' | checktime | endif
"   autocmd CursorHold,CursorHoldI,FocusGained,BufEnter * if !bufexists("[Command Line]") | checktime | endif
" augroup END
"
" Do not extend comments automatically, e.g., with `O`
augroup disable_autocomments
  autocmd!
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END

" This is so trailing spaces aren't visible when typing in insert mode
augroup no_whitespace_insert
  autocmd!
  autocmd InsertEnter * setlocal nolist
  autocmd InsertLeave * setlocal list
augroup END

" " clipboard
" " Sync the default (`"`) register (note for some reason `v:event["regname"]`
" " is set to the empty string instead of `"` for the default register), don't
" " use the `+` and `*` registers because Vim already tries to sync those
" " itself, so trying to do so here would create a conflict
" augroup safecopy
"   autocmd!
"   autocmd TextYankPost * silent! if v:event["regname"] ==# '' || v:event["regname"] ==# '"' | call system('~/.bin/safecopy -s',join(v:event["regcontents"],"\n")) | end
" augroup END
" " When moving to another vim instance, copy from the safe clipboard and
" " append a new line so pasting is always linewise.
" " This allows pastin between Vim instances without using `unnamedplus` which
" " can mess up using `yyp` to copy a line within a Vim session
" augroup safepaste
"   autocmd!
"   autocmd FocusGained * let @@ = system('~/.bin/safepaste -s').."\n"
" augroup END
" let @@ = system('~/.bin/safepaste -s')

" Fixes problems where Vim is just showing escaped junk in the window
if !has('nvim')
  augroup focus_redraw
    autocmd!
    autocmd FocusGained * redraw!
  augroup END
endif

augroup ft_stdin
  autocmd!
  " Don't prompt to save when piped to stdin
  autocmd StdinReadPost * setlocal buftype=nofile
augroup END

augroup diff_stdin
  autocmd!
  " Make piped diffs read only
  autocmd StdinReadPost * if &filetype == 'diff' | setlocal readonly nomodifiable | end
augroup END

augroup nofilename_nofile
  autocmd!
  " Don't prompt for saving buffers with no file
  autocmd BufEnter * if eval('@%') == '' && &buftype == '' | setlocal buftype=nofile | end
augroup END
