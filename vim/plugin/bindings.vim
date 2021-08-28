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

" `C-w` insert word at point like Emacs
" cnoremap <C-w> <C-R><C-W>

" Leader
" Leader seems to need to be set before leader mappings?
let mapleader = "\<space>"
" Can't use return because of using return to open a file or item in the
" quickfix list
" let maplocalleader = "\<CR>"
" let maplocalleader = "\<BS>"
let maplocalleader = "\\"

nnoremap cdg :call commands#Cdg('cd')<CR>
" nnoremap clg :call commands#Cdg('lcd')<CR>
" Note that `c` is change, so adding more bindings that start with `c` is
" difficult, in particular,`cg` can't be used because of `cg_`
" nnoremap cd :cd %:p:h<CR>
nnoremap cl :lcd %:p:h<CR>

" vimrc
nnoremap <leader>oi :cd ~/Developer/Dotfiles/vim/<CR>:edit init.vim<CR>:echo ""<CR>
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
" nmap <M-w> <C-w>

" Toggle Seplling
" Local to window
" nnoremap <localleader>s :set spell!<CR>

" Open Working Directory in Terminal
nnoremap <leader>T :silent !open -a Terminal "%:p:h"<CR>\|:redraw!<CR>
nnoremap <M-t> :silent !open -a Terminal "%:p:h"<CR>\|:redraw!<CR>

" Reveal Current File
" nnoremap <leader>R :silent !open -R "%:p"<CR>\|:redraw!<CR>
" nnoremap <localleader>R :silent !open -R "%:p"<CR>\|:redraw!<CR>
nnoremap <M-r> :silent !open -R "%:p"<CR>\|:redraw!<CR>

" TextMate
nnoremap <leader>E :silent !mate --async "%:p"<CR>\|:redraw!<CR>

" Default
nnoremap <localleader>O :silent !open "%:p"<CR>\|:redraw!<CR>
" nnoremap <M-O> :silent !open "%:p"<CR>\|:redraw!<CR>

" `make`
nnoremap <leader>m :make<CR>

" Rg
" Space delibrately left after
nnoremap <leader>a :Rg 
nnoremap <A-a> :Rg 
nnoremap <leader>ga :Rgg 

" Quit & Save Session
" nnoremap <A-q> :QuitSaveSession<CR>
" Don't use this `ZZ` only quits the current buffer, which is useless for
" preserving state
" nnoremap <silent> ZZ :SessionSave<CR>ZZ

" Make split resizing five lines instead of one
nnoremap <C-w>+ 5<C-w>+
nnoremap <C-w>- 5<C-w>-
nnoremap <C-w>< 5<C-w><
nnoremap <C-w>> 5<C-w>>

" Easy save
" nnoremap <C-s> :w<CR>
" inoremap <C-s> <c-o>:w<CR>

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
vnoremap <M-m> :'<,'>call bindings#LinkSourceControlMarkdownYankQuotedLines()<CR>
vnoremap <localleader>q :'<,'>call bindings#LinkSourceControlMarkdownYankQuotedLines()<CR>

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
" nnoremap <leader>r :%s//<C-r>/<C-b><right><right><right><right><right><right><BS><BS><C-e>
" vnoremap <leader>r :s//<C-r>/<C-b><right><right><right><right><right><right><right><right><right><right><BS><BS><C-e>

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
" Trying just quiting becaue that seems like what we usually want.
" nnoremap <localleader>O :!open "%:p"<CR>\|:bd<CR>
" nnoremap <localleader>C :!code "%:p"<CR>\|:bd<CR>
" nnoremap <localleader>O :!open "%:p"<CR>\|:bd<CR>:QuitIfNoBuffers<CR>
" nnoremap <localleader>C :!code "%:p"<CR>\|:bd<CR>:QuitIfNoBuffers<CR>
" nnoremap <leader>C :!code <C-r>=shellescape(getcwd())<CR><CR>\|:bd<CR>:QuitIfNoBuffers<CR>

" Quickfix
nnoremap <script> <silent> <leader>q :call bindings#ToggleQuickfixList()<CR>

" Todo
nnoremap <leader>d :call bindings#OpenTodo()<CR>

" Lint
" nnoremap <localleader>l :Lint<CR>

" Format
" nnoremap <leader>f :Format<CR>

" Run
nnoremap <localleader>e :Execute<CR>
vnoremap <localleader>e :ExecuteVisual<CR>

" Run
nnoremap <localleader>r :Run<CR>

" Make
nnoremap <localleader>m :make<CR>

" Backspace to last file
nnoremap <BS> <C-^>

" Command Line Window Edit
cnoremap <C-x><C-e> <C-f>

" Emacs Paste
inoremap <expr> <C-y> pumvisible() ? "\<C-y>" : getreg('*') ? "<C-r>*" : "<C-r>0" 
snoremap <expr> <C-y> pumvisible() ? "\<C-y>" : getreg('*') ? "<C-r>*" : "<C-r>0" 
" Fish paste
" Don't use this, `<C-v>` in insert mode is important for viewing how keys are
" interpreted.
" cnoremap <C-v> <C-r>*
" inoremap <expr> <C-v> pumvisible() ? "\<C-y>" : "<C-r>*"
" snoremap <expr> <C-v> pumvisible() ? "\<C-y>" : "<C-o>\"*p"

" Move by display line
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> <Up> gk
noremap <silent> <Down> gj

" Paste
" These don't work
" set <M-p>=\<Esc>p
" noremap <M-p> "0p
" vnoremap <M-p> "0p
" These work but cause a delay on ESC
" noremap <ESC>p "0p
" vnoremap <ESC>p "0p
noremap <leader>p "0p
vnoremap <leader>p "0p
" nnoremap <silent> <M-n> :cn<CR>
" nnoremap <silent> <M-p> :cp<CR>
nnoremap <expr> <M-n> len(getqflist()) ? ":cn<CR>" : len(argv()) > 1 ? ":next<CR>" : ":Fnext<CR>"
nnoremap <expr> <M-p> len(getqflist()) ? ":cp<CR>" : len(argv()) > 1 ? ":prev<CR>" : ":Fprev<CR>"

" This makes it so hitting `<c-z>` then changing a file then `fg` to return
" will update instantly.
" This conflicts with blocking backgrounding with `DisableBackgrounding`,
" removing until there's a way for these to co-exist
noremap <C-z> :suspend<cr>:silent checktime<cr>

" Paste from yank register (`0`)
vnoremap <M-y> "0p

" Fold
nnoremap <leader><tab> :set foldenable!<CR>
" Can't do this because it interferes with `C-i` to go forward
" nnoremap <tab> za

nnoremap <silent> <s-tab> :<c-U>call bindings#toggle_fold()<cr>
if has('gui_running')
  nnoremap <silent> <tab> :<c-u>call bindings#toggle_fold()<cr>
else
  nnoremap <silent> <tab> :<c-u>call bindings#move_forward_or_toggle_fold()<cr>
endif
