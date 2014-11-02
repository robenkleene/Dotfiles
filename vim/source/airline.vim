" Disable Special separators
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

function! AirlineInit()
    let g:airline_section_x = g:airline#section#create_left(['filetype', 'tagbar'])
    " let g:airline_section_x = (filetype, tagbar)
    let g:airline_section_y = '%{fnamemodify(getcwd(),":t")}'
    let g:airline_section_c = '%t'
    " let g:airline_section_c = '%{fnamemodify(getcwd(),":t")} %t'
endfunction
autocmd VimEnter * call AirlineInit()

let g:airline#extensions#default#layout = [
      \ [ 'y', 'c', 'x' ],
      \ [ 'b', 'z', 'warning' ]
      \ ]
  let g:airline#extensions#default#section_truncate_width = {
      \ 'b': 80,
      \ 'x': 80,
      \ 'z': 45,
      \ }
" let g:airline_theme='badwolf'
" let g:airline_theme='base16'
" **
" let g:airline_theme='bubblegum'
let g:airline_theme='dark'
" let g:airline_theme='hybrid'
" let g:airline_theme='jellybeans'
" let g:airline_theme='kalisi'
" let g:airline_theme='kolor'
" let g:airline_theme='laederon'
" *
" let g:airline_theme='light'
" let g:airline_theme='lucius'
" **
" let g:airline_theme='luna'
" *
" let g:airline_theme='molokai'
" *
" let g:airline_theme='monochrome'
" let g:airline_theme='murmur'
" let g:airline_theme='powerlineish'
" **
" let g:airline_theme='raven'
" let g:airline_theme='serene'
" let g:airline_theme='silver'
" let g:airline_theme='simple'
" let g:airline_theme='sol'
" let g:airline_theme='solarized'
" let g:airline_theme='tomorrow'
" let g:airline_theme='ubaryd'
" let g:airline_theme='understated'
" let g:airline_theme='wombat'
" let g:airline_theme='zenburn'
