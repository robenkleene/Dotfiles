" Fix for italics in tmux
set t_ZH=[3m
set t_ZR=[23m

if $TERM_PROGRAM != "Apple_Terminal"
  set termguicolors
endif

" Bootstrap vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
  execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

" Conditional Helper Function
function! Cond(cond, ...) abort
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
" Good to be accustomed to not having this, because it makes it easier when
" using implementations of Vim mode that doesn't support this (e.g., in Visual
" Studio Code)
" Plug 'machakann/vim-highlightedyank'
Plug 'editorconfig/editorconfig-vim'
" More reliable open browser
" Plug 'tyru/open-browser.vim'
" let g:netrw_nogx = 1
" nmap gx <Plug>(openbrowser-open)
" vmap gx <Plug>(openbrowser-open)
" Theme
" Plug 'nordtheme/vim'
" Plug 'catppuccin/vim', { 'as': 'catppuccin' }
" Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
" Plug 'whatyouhide/vim-gotham'
" Plug 'haishanh/night-owl.vim', { 'as': 'night-owl' }
" Plug 'bluz71/vim-nightfly-colors', { 'as': 'nightfly' }
" Plug 'EdenEast/nightfox.nvim'
" Plug 'cocopon/iceberg.vim', { 'as': 'iceberg' }
" Languages
Plug 'keith/swift.vim', { 'for': 'swift' }
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'neoclide/jsonc.vim', { 'for': 'json' }
Plug 'sophacles/vim-processing', { 'for': 'processing' }
call plug#end()

" Install missing plugins
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

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

" Hack to fix meta keys
" This causes hitting `ESC` then a letter really quickly in insert mode to
" insert an accented character
" let c='a'
" while c <= 'z'
"   exec "set <M-".tolower(c).">=\e".c
"   exec "nnoremap \e".c." <M-".tolower(c).">"
"   let c = nr2char(1+char2nr(c))
" endw

" Visual star
" This is the default in nvim
function! s:getSelectedText()
  let l:old_reg = getreg('"')
  let l:old_regtype = getregtype('"')
  norm gvy
  let l:ret = getreg('"')
  call setreg('"', l:old_reg, l:old_regtype)
  exe "norm \<Esc>"
  return l:ret
endfunction

vnoremap <silent> * :call setreg("/",
    \ substitute(<SID>getSelectedText(),
    \ '\_s\+',
    \ '\\_s\\+', 'g')
    \ )<Cr>n

vnoremap <silent> # :call setreg("/", 
    \ substitute(<SID>getSelectedText(),
    \ '\_s\+',
    \ '\\_s\\+', 'g')
    \ )<Bar>let v:searchforward = 0<Cr>n
