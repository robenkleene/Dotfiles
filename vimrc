let b:terminalorneovim = !has('gui_running') || has('nvim')

if $TERM_PROGRAM != "Apple_Terminal"
  set termguicolors
endif

" Install Vim-Plug if it is missing
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
Plug 'tpope/vim-eunuch', { 'on': [ 'Rename', 'Remove' ] }
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'guns/xterm-color-table.vim', { 'on': 'XtermColorTable' }
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf'
" Theme
" Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
" Plug 'bluz71/vim-nightfly-colors', { 'as': 'nightfly' }
" Plug 'whatyouhide/vim-gotham'
" Plug 'ghifarit53/tokyonight-vim'
Plug 'bluz71/vim-moonfly-colors', { 'as': 'moonfly' }
Plug 'haishanh/night-owl.vim', { 'as': 'night-owl' }
" Languages
Plug 'keith/swift.vim', { 'for': 'swift' }
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'neoclide/jsonc.vim', { 'for': 'json'}
Plug 'dag/vim-fish', { 'for': 'fish' }
call plug#end()

" colorscheme catppuccin_mocha
" let g:tokyonight_style = 'night' " available: night, storm
" let g:tokyonight_enable_italic = 1
" colorscheme tokyonight
" colorscheme nightfly
" let g:embark_terminal_italics = 1
" colorscheme embark
" colorscheme gotham
" colorscheme moonfly
colorscheme night-owl

autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
