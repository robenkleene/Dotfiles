nnoremap <leader><leader> :CtrlPBuffer<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>s :CtrlPBufTag<CR>



" command! Re :CtrlPMRU
" command! Bu :CtrlPBuffer
" command! Sy :CtrlPBufTag
" Ctrl-N/P for moving up and down
let g:ctrlp_prompt_mappings = {
    \ 'PrtSelectMove("j")':   ['<c-j>', '<c-n>'],
    \ 'PrtSelectMove("k")':   ['<c-k>', '<c-p>'],
    \ 'PrtHistory(-1)':       [''],
    \ 'PrtHistory(1)':        [''],
    \ }
    " 'PrtHistory(-1)':       ['<down>'],
    " 'PrtHistory(1)':        ['<up>'],
" let g:ctrlp_buffer_func = {
"     \ 'enter': 'EnterCtrlP',
"     \ 'exit':  'ExitCtrlP',
"     \ }
" function EnterCtrlP()
"     match Search /.*\%#.*/
" endfunction
" function ExitCtrlP()
" endfunction
if executable('ag')
    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
    " nnoremap K :Ag <cword><cr>
endif
" " Use the working directory, no magic with finding `.git` directories
" let g:ctrlp_working_path_mode = '0'
" " Open new files in horizontal splits
" let g:ctrlp_open_new_file = 'h'
