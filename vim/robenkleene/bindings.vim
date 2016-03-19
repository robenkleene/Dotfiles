" Key Commands {{{1

" `C-G` to `<Esc>` like Emacs
nnoremap <C-g> <Esc>:f<CR>
inoremap <C-g> <Esc>:f<CR>
vnoremap <C-g> <Esc>:f<CR>
" rsi plugin handles this
" cnoremap <C-g> <Esc>

" Fix Y
nnoremap Y y$

" `C-y` paste like in Emacs
cnoremap <C-y> <C-r>*
inoremap <C-y> <C-r>*

" `C-w` insert word at point like Emacs
cnoremap <C-w> <C-R><C-W>

" Tabs
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>te :tabedit %<CR>

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

" Markdown link
" nnoremap <leader>l :!mdlinkforfile "%" <BAR> pbcopy<CR>\|:redraw!<CR>
" vnoremap <leader>l :w !mdlinkforfile "%" <BAR> pbcopy<CR>\|:redraw!<CR>
