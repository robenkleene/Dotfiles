" Fix for italics in tmux
set t_ZH=[3m
set t_ZR=[23m

" Bootstrap vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
  execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }
" The built in `:Man` command uses `-complete=shellcmd`
" This needs to be loaded before `vim-sensible` to prevent sensible from
" loading the builtin `:Man` first
Plug 'vim-utils/vim-man'
" This breaks completion before running the command once
" Plug 'vim-utils/vim-man', { 'on': 'Man' }
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
" `editorconfig` is conflicting with `foldmethod=indent`
Plug 'editorconfig/editorconfig-vim'
Plug 'robenkleene/partshell.vim'
Plug 'robenkleene/gotogrep.vim'
" More reliable open browser
Plug 'tyru/open-browser.vim'
let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-open)
vmap gx <Plug>(openbrowser-open)
" Languages
Plug 'bfrg/vim-c-cpp-modern', { 'for': [ 'c', 'cpp' ] }
Plug 'keith/swift.vim', { 'for': 'swift' }
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'neoclide/jsonc.vim', { 'for': 'json' }
call plug#end()

" Install missing plugins
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

if $TERM_PROGRAM != "Apple_Terminal" || exists('$SSH_CONNECTION') || exists('$TMUX')
  set background=dark
endif
" colorscheme wildcharm
colorscheme lunaperche

" Needs to happen before bindings are set
let mapleader="\<Space>"

" Indent
" When opening lines, make it the same indent level as the current line
" Neovim defaults to `autoindent`
set autoindent

" Highlight search results
" This is important even when doing a substitution, because it makes clear
" when you might have false positives
" Neovim defaults to `hlsearch`
set hlsearch

" Fix a problem in Vim where a bunch of escaped junk is shown in the window
augroup focus_redraw
  autocmd!
  autocmd FocusGained * redraw!
augroup END

" Fix option key in Vim
let c='a'
while c <= 'z'
  exec "set <M-".tolower(c).">=\e".c
  exec "nnoremap \e".c." <M-".tolower(c).">"
  let c = nr2char(1+char2nr(c))
endw
