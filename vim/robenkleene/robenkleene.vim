" Startup {{{1

if &shell =~# 'fish$'
  set shell=bash
endif

" Plugins {{{1

" Install Vim-Plug if it is missing
if empty(glob("~/.vim/autoload/plug.vim"))
  execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

" Conditional Helper Function
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin('~/.vim/plugged')
" Tim Pope {{{2
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-scriptease'
" Colors {{{2
Plug 'guns/xterm-color-table.vim', { 'on': 'XtermColorTable' }
Plug 'ap/vim-css-color'
" Editing {{{2
Plug 'editorconfig/editorconfig-vim'
Plug 'bogado/file-line'
Plug 'scrooloose/syntastic'
Plug 'junegunn/rainbow_parentheses.vim', { 'on': 'RainbowParentheses' }
Plug 'janko-m/vim-test', { 'on': ['TestNearest', 'TestFile', 'TestSuite', 
      \ 'TestLast', 'TestVisit'] }
Plug 'Konfekt/FastFold'
Plug 'Shougo/neocomplete.vim', Cond(has('lua') && !has('nvim'))
Plug 'Shougo/deoplete.nvim', Cond(has('nvim') && has('python3'), { 'do': ':UpdateRemotePlugins' })
" Git {{{2
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" Navigation {{{2
Plug 'ctrlpvim/ctrlp.vim', Cond(!has('gui_running') && !has('nvim'))
Plug 'junegunn/fzf', Cond(has('nvim'))
Plug 'junegunn/fzf.vim', Cond(has('nvim'))
" Languages {{{2
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'keith/swift.vim', { 'for': 'swift' }
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
call plug#end()

" Source {{{1
source ~/.vim/robenkleene/settings.vim
source ~/.vim/robenkleene/ui.vim
if !has('gui_running')
  source ~/.vim/robenkleene/colors.vim
endif
if has("gui_vimr")
  source ~/.gvimrc
endif
source ~/.vim/robenkleene/commands.vim
source ~/.vim/robenkleene/bindings.vim
source ~/.vim/robenkleene/abbreviations.vim

" Plugins {{{1
source ~/.vim/robenkleene/plugin/commentary.vim
if !has('gui_running') || has('gui_vimr')
  source ~/.vim/robenkleene/plugin/fzf.vim
else
  source ~/.vim/robenkleene/plugin/ctrlp.vim
end
source ~/.vim/robenkleene/plugin/test.vim
source ~/.vim/robenkleene/plugin/fugitive.vim

if has('nvim') && has("python3")
  source ~/.vim/robenkleene/plugin/deoplete.vim
elseif has('lua')
  source ~/.vim/robenkleene/plugin/neocomplete.vim
endif
source ~/.vim/robenkleene/plugin/surround.vim
source ~/.vim/robenkleene/plugin/syntastic.vim
source ~/.vim/robenkleene/plugin/rainbow_parentheses.vim
source ~/.vim/robenkleene/plugin/vim-gitgutter.vim
