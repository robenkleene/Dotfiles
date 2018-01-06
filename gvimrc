" vim:foldmethod=marker

" Path
let $PATH=$HOME . '/.nvm/versions/node/v0.12.2/bin:' . $HOME . '/.rbenv/shims:'. $HOME . '/.rbenv/bin:/usr/local/bin:' . $HOME . '/Development/Scripts/bin:' . $PATH

" General {{{1
set macmeta

" User Interface {{{1

" Disable gui menus
set guioptions+=c

" Window
if !exists("s:deja_vu") 
  set guioptions-=T " Disable toolbar
  set guioptions-=L " Disable left scroll bar with vertical splits
  set guioptions-=r " Disable right scrollbar
  set guioptions-=e " Disable visual tabs
  " Size
  set lines=48 " Rows
  set columns=80 " Columns
  " Fonts
  set guifont=Menlo\ Regular:h12 " Set font
  set gcr=a:blinkon0 " Disable Cursor blinking
  " set noantialias " No anti-aliasing sometimes looks better
  " set transparency=5
endif 
let s:deja_vu = 1

" Key Commands {{{1
nnoremap <leader>sv :source $MYVIMRC<CR>:source $MYGVIMRC<CR>:echo "Sourced"<CR>
