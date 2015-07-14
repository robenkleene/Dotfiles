" vim:foldmethod=marker

" Key Commands {{{1

" `C-G` to `<Esc>` like Emacs
nnoremap <C-g> <Esc>
let g:surround_no_insert_mappings = 1
inoremap <C-g> <Esc>
vnoremap <C-g> <Esc>
" rsi plugin handles this
" cnoremap <C-g> <Esc>

" vimrc
nnoremap <leader>oi :edit $MYVIMRC<CR>
nnoremap <leader>si :source $MYVIMRC<CR>:echo "Sourced"<CR>

" Toggle No Wrap
nnoremap <leader>w :set wrap!<CR>

" Open Working Directory in Terminal
nnoremap <leader>t :silent !open -a Terminal "%:p:h"<CR>\|:redraw!<CR>

" Reveal Current File
nnoremap <leader>r :silent !open -R "%:p"<CR>\|:redraw!<CR>

" Open File in TextMate
nnoremap <leader>e :silent !mate --async "%:p"<CR>\|:redraw!<CR>

" Detect File type
" map <leader>d :filetype detect<CR>

" Use normal mode C-L in insert mode
" inoremap <silent> <C-L> <C-O>:nohlsearch<CR><C-O><C-L>
