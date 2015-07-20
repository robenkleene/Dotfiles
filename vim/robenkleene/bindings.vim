" vim:foldmethod=marker

" Key Commands {{{1

" `C-G` to `<Esc>` like Emacs
nnoremap <C-g> <Esc>
let g:surround_no_insert_mappings = 1
inoremap <C-g> <Esc>
vnoremap <C-g> <Esc>
" rsi plugin handles this
" cnoremap <C-g> <Esc>

" `C-y` paste like in Emacs
cnoremap <C-y> <C-r>*
inoremap <C-y> <C-r>*

" `C-w` insert word at point like Emacs
cnoremap <C-w> <C-R><C-W>

" vimrc
nnoremap <leader>oi :edit ~/Dotfiles/vimrc<CR>
nnoremap <leader>si :source $MYVIMRC<CR>:echo "Sourced"<CR>

" Bookmarks
nnoremap <leader>op :edit ~/Dotfiles/vim/bundle/<CR>
nnoremap <leader>ob :CtrlPDirectoryBookmarks<CR>

" Toggle No Wrap
nnoremap <leader>w :set wrap!<CR>

" Open Working Directory in Terminal
nnoremap <leader>t :silent !open -a Terminal "%:p:h"<CR>\|:redraw!<CR>

" Reveal Current File
nnoremap <leader>r :silent !open -R "%:p"<CR>\|:redraw!<CR>

" Open File in TextMate
nnoremap <leader>e :silent !mate --async "%:p"<CR>\|:redraw!<CR>

" Copy Current line to clipboard cleaned for shell pasting
" I.e., this removes any whitespace form the beginning and end of the line
" and removes the last new line
nnoremap <silent> <leader>yy :silent .w !sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' 
            \ <BAR> tr -d "\n" <BAR> pbcopy<CR>

" Detect File type
" map <leader>d :filetype detect<CR>

" Use normal mode C-L in insert mode
" inoremap <silent> <C-L> <C-O>:nohlsearch<CR><C-O><C-L>
