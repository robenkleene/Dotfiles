" Exclude some buffers from restoring view settings, this prevents certain
" buffers that are meant to be transient from being save and restored when
" loading sessions
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

" Autoreload files edited by other programs
set autoread
" `CursorHold` interval in ms, default is `4000`
set updatetime=1000
" This causes a delay when opening the command-line window with `<C-f>`?
" Maybe `set autoread` is enough?
augroup reload_buffers
  autocmd!
  " Oddly, `silent! checktime` doesn't seem to update after a `git checkout
  " <file>` while just `checktime` does. (`silent! checktime` when editing the
  " same file in another `vim` instance though.)
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' && expand('%') !=# '[Command Line]' && getcmdwintype() == '' | checktime | endif
augroup END

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

augroup nofilename_nofile
  autocmd!
  " Don't prompt for saving buffers with no file
  autocmd BufEnter * if eval('@%') == '' && &buftype == '' | setlocal buftype=nofile | end
augroup END

augroup safecopy
  autocmd!
  " We can't add delete (`v:event["operator"] ==# 'd'`) because then doing a
  " visual selection (e.g., `v`) then system clipboard paste (`"*p`) will
  " first delete the visual selection then paste, which means the visual
  " selection will overwrite the clipboard
  autocmd TextYankPost * if v:event["regname"] !=# '*' && v:event["regname"] !=# '+' && v:event["operator"] ==# 'y' | call system('safecopy',join(v:event["regcontents"],"\n")) | end
augroup END

augroup quickfix_height
  autocmd!
  " Set the height to the number of lines, or a fraction of the window height
  " (with a maximum), which ever is higher
  autocmd FileType qf execute min([line("$"), max([10, float2nr(&lines / 3)])]) . "wincmd _"
augroup END

augroup z_add
  autocmd!
  " netrw
  autocmd Filetype netrw call system('zoxide add '.shellescape(expand('%')))
  " Regular `cd` or `lcd`
  autocmd DirChanged * call system('zoxide add ' . expand('<amatch>'))
augroup END

" Automatically close the completion preview
augroup completion_preview
  autocmd!
  autocmd CompleteDone * pclose
augroup END

" Remove commit files from `v:oldfiles` (note this doesn't touch the edited
" files on disk, it filters the list when vim launches)
" Don't like that this might affect startup time
augroup clean_oldfiles
  autocmd!
  autocmd VimEnter * call filter(v:oldfiles, 'v:val !~# "COMMIT_EDITMSG$" && v:val !~# ".*\.hg\.txt$"')
augroup END

highlight Comment guifg=#8B8680 ctermfg=244 guibg=NONE ctermbg=NONE
highlight Normal ctermbg=NONE guibg=NONE
augroup override_colors
  autocmd!
  autocmd ColorScheme * highlight Comment guifg=#8B8680 ctermfg=244 guibg=NONE ctermbg=NONE
  autocmd ColorScheme * highlight Normal ctermbg=none guibg=none
augroup END
