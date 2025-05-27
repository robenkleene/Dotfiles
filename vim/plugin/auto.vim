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
  autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
augroup END

augroup executable_files
  autocmd!
  autocmd BufWritePost *.zsh,*.py,*.pl,*.sh,*.rb,*.swift :call auto#MakeShebangFilesExecutable()
augroup END
