vim.cmd([[
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

augroup auto_save_session
  autocmd!
  autocmd VimLeave * mksession! ~/.vim/vim_auto_session
augroup END

augroup quickfix_height
  autocmd!
  autocmd FileType qf call auto#AdjustWindowHeight(3, 20)
augroup END

augroup executable_files
  autocmd!
  autocmd BufWritePost *.zsh,*.py,*.pl,*.sh,*.rb,*.swift :call auto#MakeShebangFilesExecutable()
augroup END
]])

