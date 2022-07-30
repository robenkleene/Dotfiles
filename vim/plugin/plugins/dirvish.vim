augroup dirvish_config
  autocmd!
  autocmd FileType dirvish nnoremap <silent><buffer>gh :<C-u>DirvishToggleHidden<CR>:Dirvish %<CR>
  autocmd FileType dirvish nnoremap <buffer><silent> <C-l> :Dirvish %<CR>:nohlsearch<CR>
  " Adding `:Dirvish %<CR>` fixes an issue when doing `cl` followed by hitting
  " enter on a file or directory
  autocmd FileType dirvish nnoremap <buffer><silent> cl :lcd %:p:h<CR>:Dirvish %<CR>
  " autocmd FileType dirvish nnoremap <buffer><localleader>m :call <SID>SetupCommandOnFile("mv")<CR>
  " autocmd FileType dirvish nnoremap <buffer><localleader>d :call <SID>SetupRemoveCommandOnFile()<CR>
  " autocmd FileType dirvish nnoremap <buffer><localleader>c :call <SID>SetupCommandOnFile("cp")<CR>
  " autocmd FileType dirvish nnoremap <buffer><localleader>+ :!mkdir 
  " All of these call `:Dirvish %<CR>` first because if the directory has
  " changed, e.g., via a `:cd` or `:lcd`, then the paths in the buffer will no
  " longer be valid, so they need to be refreshed.
  autocmd FileType dirvish nnoremap <buffer>mv :Dirvish %<CR>:call <SID>SetupCommandOnFile("mv -n")<CR>
  autocmd FileType dirvish nnoremap <buffer>M :Dirvish %<CR>:call <SID>SetupCommandOnFile("mv -n")<CR>
  autocmd FileType dirvish nnoremap <buffer>rd :Dirvish %<CR>:call <SID>SetupRemoveCommandOnFile()<CR>
  autocmd FileType dirvish nnoremap <buffer>rm :Dirvish %<CR>:call <SID>SetupCommandOnFile("rm")<CR>
  autocmd FileType dirvish nnoremap <buffer>R :Dirvish %<CR>:call <SID>SetupCommandOnFile("rm")<CR>
  autocmd FileType dirvish nnoremap <buffer>cp :Dirvish %<CR>:call <SID>SetupCommandOnFile("cp")<CR>
  autocmd FileType dirvish nnoremap <buffer>C :Dirvish %<CR>:call <SID>SetupCommandOnFile("cp")<CR>
  autocmd FileType dirvish nnoremap <buffer>mk :Dirvish %<CR>:!mkdir 
  " Dirvish maps these for the following reason, probably a mistake to unmap
  " but I find them ugly
  " "Buffer-local / and ? mappings to skip the concealed path fragment."
  autocmd FileType dirvish if !empty(maparg('/', 'n')) | nunmap <buffer> /| endif
  autocmd FileType dirvish if !empty(maparg('?', 'n')) | nunmap <buffer> ?| endif
  " Autochange the directory
  " autocmd FileType dirvish silent! lcd %:p:h
augroup END

" This shouldn't be necessary anymore
" augroup DirvishShellRefresh
"   autocmd FileType dirvish :autocmd! DirvishShellRefresh ShellCmdPost <buffer> :Dirvish %
" augroup END

" Go to `git` root
command! Cdg :call commands#Cdg('cd')
command! Lcdg :call commands#Cdg('lcd')
command! DirvishToggleHidden call <SID>ToggleHidden()
command! SetupCommandOnFile call <SID>SetupCommandOnFile()

function! s:ToggleHidden() abort
  if exists("g:dirvish_mode")
    unlet g:dirvish_mode
  else
    " This is the official way, but this doesn't work with
    " `g:dirvish_relative_paths`
    " let g:dirvish_mode = ':silent keeppatterns g@\v/\.[^\/]+/?$@d _'
    " This simpler pattern works with `g:dirvish_relative_paths`
    " let g:dirvish_mode = ':silent keeppatterns g/^\..\+/d'
    " `@` is alternative regex syntax
    " `d` is for delete
    let g:dirvish_mode = ':silent keeppatterns g@\v(/|^)\.[^\/]+@d _'
  endif
endfunction

function! s:SetupCommandOnFile(cmd) abort
  let reg_save = @@
  if exists("@*")
    let reg_save2 = @*
  endif
  silent exe "normal! ^yg_"
  let filename_string = @@
  let filename = fnameescape(expand(filename_string))
  let @@ = a:cmd
  " This doesn't use `silent` because `silent requires a `:redraw!` after
  call feedkeys(':!' . a:cmd . " " . filename . " ")
  let @@ = reg_save
  if exists("@*")
    let @* = reg_save2
  endif
endfunction

function! s:SetupRemoveCommandOnFile() abort
  let reg_save = @@
  if exists("@*")
    let reg_save2 = @*
  endif
  silent exe "normal! ^yg_"
  let filename_string = @@
  let filename = fnameescape(expand(filename_string))
  if filereadable(filename_string)
    let cmd = "rm"
  else
    let cmd = "rmdir"
  endif
  " This doesn't use `silent` because `silent requires a `:redraw!` after
  call feedkeys(':!' . cmd . " " . filename)
  let @@ = reg_save
  if exists("@*")
    let @* = reg_save2
  endif
endfunction

" Default to hidden
" This causes hidden directories to fail, e.g., if you edit a path in a hidden
" directory like:
" `.github/workflows/ci.yml`
" And then hit `-` to enter Dirvish, you'll have an empty window instead of
" the directories contents
" call <SID>ToggleHidden()

" This makes it easier to yank what is expected
let g:dirvish_relative_paths = 1
