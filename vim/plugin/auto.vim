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
if !has('gui_running')
  highlight Normal ctermbg=NONE guibg=NONE
endif
augroup override_colors
  autocmd!
  autocmd ColorScheme * highlight Comment guifg=#8B8680 ctermfg=244 guibg=NONE ctermbg=NONE
  if !has('gui_running')
    autocmd ColorScheme * highlight Normal ctermbg=NONE
  endif
augroup END

augroup executable_files
  autocmd!
  autocmd BufWritePost *.zsh,*.py,*.pl,*.sh,*.rb,*.swift :call auto#MakeShebangFilesExecutable()
augroup END

augroup safecopy
  autocmd!
  " Only copy to system clipboard on yank
  " We can't add delete (`v:event["operator"] ==# 'd'`) because then doing a
  " visual selection (e.g., `v`) then system clipboard paste (`"*p`) will
  " first delete the visual selection then paste, which means the visual
  " selection will overwrite the clipboard
  " Don't copy to system clipboard if the register is `*` or `+`, since those
  " already copy to the system clipboard
  " Note: This currently isn't working from `nvim` (fails silently)
  autocmd TextYankPost * if v:event["regname"] !=# '*' && v:event["regname"] !=# '+' && v:event["operator"] ==# 'y' | call system('~/.bin/nobin/_safecopy.sh',join(v:event["regcontents"],"\n")) | end
augroup END
