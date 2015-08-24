nnoremap <leader>s :CtrlPBufTag<CR>

" Use CtrlPMRU for old files
cabbrev ol <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'CtrlPMRU' : 'ol')<CR>
" cabbrev ls <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'CtrlPBuffer' : 'ls')<CR>
nnoremap <leader>b :CtrlPBuffer<CR>

" Can't use `<C-p>` because that inteferes with Emacs style down
let g:ctrlp_map = '<leader>f'

" Search buffers, files, and recently used
let g:ctrlp_cmd = 'CtrlPMixed'

" Ctrl-N/P for moving up and down
let g:ctrlp_prompt_mappings = {
      \ 'PrtSelectMove("j")':   ['<c-j>', '<c-n>'],
      \ 'PrtSelectMove("k")':   ['<c-k>', '<c-p>'],
      \ 'PrtHistory(-1)':       [''],
      \ 'PrtHistory(1)':        [''],
      \ }

" Use `ag` if available
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


" Setup my bookmark system
let g:ctrlp_extensions = ['ctrlp_directory_bookmarks']
let g:ctrlp_directory_bookmarks_list = [
      \ '~/Dotfiles/',
      \ '~/Development',
      \ '~/Development/Scratch',
      \ '~/Development/Scratch/Temp',
      \ '~/Development/Projects/',
      \ ]
