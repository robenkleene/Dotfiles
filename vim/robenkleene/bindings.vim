" Key Commands {{{1

" `C-G` to `<Esc>` like Emacs
" nnoremap <C-g> <Esc>:f<CR>
" inoremap <C-g> <Esc>:f<CR>
" " rsi plugin handles this
" cnoremap <C-g> <Esc>
" rsi plugin implementation
cmap <script> <C-G> <C-C>
vnoremap <C-g> <Esc>:f<CR>

" Backwards delete word
" noremap! <M-BS> <C-W>
" if !has("gui_running") && !has('nvim')
"   silent! exe "set <F34>=\<Esc>\<C-?>"
"   silent! exe "set <F35>=\<Esc>\<C-H>"
"   map! <F34> <M-BS>
"   map! <F35> <M-BS>
"   map <F34> <M-BS>
"   map <F35> <M-BS>
" endif

" Fix Y
nnoremap Y y$

" Alternative exit insert mode
" inoremap jk <esc>

" `C-y` paste like in Emacs
" cnoremap <C-y> <C-r>*
" inoremap <C-y> <C-r>*

" `C-w` insert word at point like Emacs
" cnoremap <C-w> <C-R><C-W>

" Tabs
" nnoremap <leader>tn :tabnew<CR>
" nnoremap <leader>tc :tabclose<CR>
" nnoremap <leader>te :tabedit %<CR>

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

" Move frames
" Handled by `vim-tmux-navigator`
" nnoremap <S-Down> <C-w><C-j>
" nnoremap <S-Up> <C-w><C-k>
" nnoremap <S-Right> <C-w><C-l>
" nnoremap <S-Left> <C-w><C-h>


" Markdown link
nnoremap <leader>m :!mdlinkforfile "%"  "\#L<C-r>=line('.')<CR>" <BAR> pbcopy<CR>\|:redraw!<CR>
vnoremap <leader>m :w !mdlinkforfile "%" <BAR> pbcopy<CR>\|:redraw!<CR>

" Copy Path
nnoremap <leader>p :let @*=expand("%:p")<CR>

" Visual Star
" makes * and # work on visual mode too.
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" Panes
" The problem with tmux vim navigator is that if vim is opened form a subprocess 
" in a tmux pane (e.g., `tig -> vim`), then moving between vim panes will break,
" because tmux won't be able to detect that vim is actually running as a child
" of `tig`.
let c='a'
while c <= 'z'
  exec "set <M-".tolower(c).">=\e".c
  exec "nnoremap \e".c." <M-".tolower(c).">"
  let c = nr2char(1+char2nr(c))
endw
noremap <silent> <A-h> <C-w>h
noremap <silent> <A-j> <C-w>j
noremap <silent> <A-k> <C-w>k
noremap <silent> <A-l> <C-w>l

noremap <silent> <S-Left> <C-w>h
noremap <silent> <S-Down> <C-w>j
noremap <silent> <S-Up> <C-w>k
noremap <silent> <S-Right> <C-w>l
