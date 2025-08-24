augroup quickfix_height
  autocmd!
  " Set the height to the number of lines, or a fraction of the window height
  " (with a maximum), which ever is higher
  autocmd FileType qf execute min([line("$"), max([10, float2nr(&lines / 3)])]) . "wincmd _"
augroup END

" Remove commit files from `v:oldfiles` (note this doesn't touch the edited
" files on disk, it filters the list when vim launches)
" Don't like that this might affect startup time
" Removing this because it might affect startup time
"augroup clean_oldfiles
"  autocmd!
"  autocmd VimEnter * call filter(v:oldfiles, 'v:val !~# "COMMIT_EDITMSG$" && v:val !~# ".*\.hg\.txt$"')
"augroup END

highlight Comment guifg=#8B8680 ctermfg=244 guibg=NONE ctermbg=NONE
highlight Normal ctermbg=NONE guibg=NONE
augroup override_colors
  autocmd!
  autocmd ColorScheme * highlight Comment guifg=#8B8680 ctermfg=244 guibg=NONE ctermbg=NONE
  autocmd ColorScheme * highlight Normal ctermbg=NONE
augroup END

augroup executable_files
  autocmd!
  autocmd BufWritePost *.zsh,*.py,*.pl,*.sh,*.rb,*.swift :call auto#MakeShebangFilesExecutable()
augroup END

let g:yank_next = 0
nnoremap <silent> "* :<C-U>let g:yank_next = 1<CR>
vnoremap <silent> "* :<C-U>let g:yank_next = 1<CR>gv
nnoremap <silent> "+ :<C-U>let g:yank_next = 1<CR>
vnoremap <silent> "+ :<C-U>let g:yank_next = 1<CR>gv
" This is because cut and pasting from the system clipboard pastes linewise
" The problem with these is that it won't work to paste from the system
" clipboard to Vim in a remote session, so disabling
" cnoremap <silent> <C-r>* <C-r>=system('~/.bin/safepaste')<CR>
" inoremap <silent> <C-r>* <C-r>=system('~/.bin/safepaste')<CR>
" cnoremap <silent> <C-r>+ <C-r>=system('~/.bin/safepaste')<CR>
" inoremap <silent> <C-r>+ <C-r>=system('~/.bin/safepaste')<CR>
augroup safecopy_yank
  autocmd!
  autocmd TextYankPost * if g:yank_next | call system('~/.bin/safecopy',join(v:event["regcontents"],"\n")) | let g:yank_next = 0 | end
augroup END
