" Key Commands {{{1

" `C-G` to `<Esc>` like Emacs
" rsi plugin implementation
cnoremap <script> <C-G> <C-C>
" vnoremap <C-g> <Esc>:f<CR>

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

" Leader
" Leader seems to nned to be set before leader mappings?
let mapleader = "\<space>"
let maplocalleader = "\\"

nnoremap cdg :call commands#Cdg('cd')<CR>
" nnoremap clg :call commands#Cdg('lcd')<CR>
" Note that `c` is change, so adding more bindings that start with `c` is
" difficult, in particular,`cg` can't be used because of `cg_`
" nnoremap cd :cd %:p:h<CR>
nnoremap cl :lcd %:p:h<CR>

" vimrc
nnoremap <leader>oi :cd ~/Development/Dotfiles/vim/<CR>:edit init.vim<CR>:echo ""<CR>
nnoremap <leader>si :source $MYVIMRC<CR>:echo "Sourced"<CR>
" Macros
" nnoremap <leader>om :new<CR>:set buftype=nofile<CR>V"wp
" nnoremap <leader>sm V"wd:bd<CR>
" This is a good way to quickly edit a macro
" nnoremap <leader>om :<c-u><c-r><c-r>='let @w='.string(getreg('w'))<CR><C-f><left>
" Local Settings
" Can't use `s` because it conflicts with "s" for snippets
" `l` is for "local"
nnoremap <leader>sl :source vim_settings<CR>
nnoremap <leader>ol :edit vim_settings<CR>
" Build Log
nnoremap <leader>ob :edit build.log<CR>
nnoremap <leader>ot :edit test.log<CR>

" Documentation
" nnoremap <leader>d :split ~/Documentation/development-references/Vim/<CR>:cd %<CR>:echo ""<CR>

" Toggle No Wrap
" Local to window
nnoremap <localleader>w :set wrap!<CR>
nnoremap <leader>w :set wrap!<CR>
" nnoremap <M-w> :set wrap!<CR>
nmap <M-w> <C-w>

" Toggle Seplling
" Local to window
nnoremap <localleader>s :set spell!<CR>

" Open Working Directory in Terminal
nnoremap <leader>T :silent !open -a Terminal "%:p:h"<CR>\|:redraw!<CR>
nnoremap <M-t> :silent !open -a Terminal "%:p:h"<CR>\|:redraw!<CR>

" Reveal Current File
nnoremap <leader>R :silent !open -R "%:p"<CR>\|:redraw!<CR>
nnoremap <localleader>R :silent !open -R "%:p"<CR>\|:redraw!<CR>
nnoremap <M-r> :silent !open -R "%:p"<CR>\|:redraw!<CR>

" TextMate
nnoremap <leader>E :silent !mate --async "%:p"<CR>\|:redraw!<CR>

" Default
nnoremap <leader>O :silent !open "%:p"<CR>\|:redraw!<CR>
nnoremap <M-o> :silent !open "%:p"<CR>\|:redraw!<CR>

" `make`
nnoremap <leader>m :make<CR>

" Rg
" Space delibrately left after
nnoremap <leader>a :Rg 
nnoremap <leader>ga :Rgg 

" Quit & Save Session
nnoremap <A-q> :QuitSaveSession<CR>
" Don't use this `ZZ` only quits the current buffer, which is useless for
" preserving state
" nnoremap <silent> ZZ :SessionSave<CR>ZZ

" Make split resizing five lines instead of one
nnoremap <C-w>+ 5<C-w>+
nnoremap <C-w>- 5<C-w>-
nnoremap <C-w>< 5<C-w><
nnoremap <C-w>> 5<C-w>>

" Easy save
nnoremap <C-s> :w<CR>
inoremap <C-s> <c-o>:w<CR>

" Copy Current line to clipboard cleaned for shell pasting
" I.e., this removes any whitespace form the beginning and end of the line
" and removes the last new line
" nnoremap <silent> <leader>yy :silent .w !sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' 
"             \ <BAR> tr -d "\n" <BAR> pbcopy<CR>

" Move frames
" Handled by `vim-tmux-navigator`
" nnoremap <S-Down> <C-w><C-j>
" nnoremap <S-Up> <C-w><C-k>
" nnoremap <S-Right> <C-w><C-l>
" nnoremap <S-Left> <C-w><C-h>

" Yank Git Links
command! LinkSourceControlYank call bindings#LinkSourceControlYank()
command! -range LinkSourceControlYankLines <line1>,<line2>call bindings#LinkSourceControlYankLines()
" nnoremap <localleader>gl :call bindings#LinkSourceControlYank()<CR>
" vnoremap <localleader>gl :'<,'>call bindings#LinkSourceControlYankLines()<CR>
" Yank Git Markdown Links
command! LinkSourceControlMarkdownYank call bindings#LinkSourceControlMarkdownYank()
command! -range LinkSourceControlMarkdownYankLines <line1>,<line2>call bindings#LinkSourceControlMarkdownYankLines()
" nnoremap <localleader>gm :call bindings#LinkSourceControlMarkdownYank()<CR>
" vnoremap <localleader>gm :'<,'>call bindings#LinkSourceControlMarkdownYankLines()<CR>
" Open Git Links
command! LinkSourceControlOpen call bindings#LinkSourceControlOpen()
command! -range LinkSourceControlOpenLines <line1>,<line2>call bindings#LinkSourceControlOpenLines()
" nnoremap <localleader>go :call bindings#LinkSourceControlOpen()<CR>
" vnoremap <localleader>go :'<,'>call bindings#LinkSourceControlOpenLines()<CR>
" Yank quoted portion
command! -range LinkSourceControlMarkdownYankQuotedLines <line1>,<line2>call bindings#LinkSourceControlMarkdownYankQuotedLines()
" vnoremap <localleader>gq :'<,'>call bindings#LinkSourceControlMarkdownYankQuotedLines()<CR>
vnoremap <M-q> :'<,'>call bindings#LinkSourceControlMarkdownYankQuotedLines()<CR>

" Copy Path
nnoremap <leader>yp :let @*=expand("%:p")<CR>
nnoremap <leader>yf :let @*=expand("%:t")<CR>
nnoremap <leader>yd :let @*=expand('%:p:h:t')<CR>

" `grep` Visual Star
" makes * and # work on visual mode too.
xnoremap * :<C-u>call bindings#VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call bindings#VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
" `rg` Visual Star
" With a visual selection, an exact term is searched for
" With no visual selection, the current word is searched for
" (The `\\|` is not intuitive, this is because `|` separates commands in
" Vimscript)
nnoremap <leader>* :Rg '(^\\|\W)<C-r><C-w>($\\|\W)'<CR>
vnoremap <leader>* :<C-u>call bindings#GrepVisual()<CR>
" Replace
" Can't delete the word boundary because that will delete some characters if we made a selection first.
nnoremap <leader>r :%s//<C-r>/<C-b><right><right><right><right><right><right><BS><BS><C-e>
vnoremap <leader>r :s//<C-r>/<C-b><right><right><right><right><right><right><right><right><right><right><BS><BS><C-e>

" Panes
" The problem with `tmux` Vim navigator is that if Vim is opened form a
" subprocess in a `tmux` pane (e.g., `tig -> Vim`), then moving between Vim
" panes will break, because `tmux` won't be able to detect that Vim is
" actually running as a child of `tig`.

" Easy Movements
" noremap <A-h> <C-w>h
" noremap <A-j> <C-w>j
" noremap <A-k> <C-w>k
" noremap <A-l> <C-w>l
" nnoremap <A-n> gt
" nnoremap <A-p> gT
" vnoremap <A-n> gt
" vnoremap <A-p> gT
" noremap <S-Left> <C-w>h
" noremap <S-Down> <C-w>j
" noremap <S-Up> <C-w>k
" noremap <S-Right> <C-w>l

" Open and Close Tab
nnoremap <C-w>t :split<CR><C-w>T
" nnoremap <C-w>t :tabnew<CR>
" vnoremap <C-w>t :<C-u>tabnew<CR>
vnoremap <C-w>t :split<CR><C-w>T
nnoremap <C-w>q :tabclose<CR>
vnoremap <C-w>q :<C-u>tabclose<CR>
" Switching Tabs
nnoremap <C-w>n gt
nnoremap <C-w><C-n> gt
nnoremap <C-w>p gT
nnoremap <C-w><C-p> gT
vnoremap <C-w>n gt
vnoremap <C-w><C-n> gt
vnoremap <C-w>p gT
vnoremap <C-w><C-p> gT
" quickfix
" nnoremap <A-Down> :cnext<CR>
" nnoremap <A-Up> :cprev<CR>
" vnoremap <A-Down> :cnext<CR>
" vnoremap <A-Up> :cprev<CR>
" nnoremap <A-n> :cnext<CR>
" nnoremap <A-p> :cprev<CR>
" vnoremap <A-n> :cnext<CR>
" vnoremap <A-p> :cprev<CR>

" Open
" Close with `bd` after open to avoid the possibility of data loss when
" editing with a different program
nnoremap <localleader>O :!open "%:p"<CR>\|:bd<CR>

" Quickfix
nnoremap <script> <silent> <leader>q :call bindings#ToggleQuickfixList()<CR>

" Todo
nnoremap <leader>d :call bindings#OpenTodo()<CR>

" Lint
nnoremap <localleader>l :Lint<CR>

" Format
nnoremap <localleader>f :Format<CR>

" Run
nnoremap <localleader>e :Execute<CR>
vnoremap <localleader>e :ExecuteVisual<CR>

" Run
nnoremap <localleader>r :Run<CR>

" Emacs Paste
cnoremap <C-y> <C-r>*
inoremap <expr> <C-y> pumvisible() ? "\<C-y>" : "<C-r>*"
snoremap <expr> <C-y> pumvisible() ? "\<C-y>" : "<C-o>\"*p"
