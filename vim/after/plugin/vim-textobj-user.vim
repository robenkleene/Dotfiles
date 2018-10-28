if match(&runtimepath, 'vim-textobj-user') == -1
  finish
endif

" Note that `asterisk` and `underscore` are only for Markdown, but
" `textobj-user` doesn't have a way to specify a `textobj` is `filetype`
" specific, so this is loaded globally.
call textobj#user#plugin('asterisk', {
\   '-': {
\     'select-a-function': 'FindAsteriskA',
\     'select-a': 'a*',
\     'select-i-function': 'FindAsteriskI',
\     'select-i': 'i*',
\   },
\ })

function! FindAsteriskA()
  normal! F*
  let head_pos = getpos('.')
  normal! f*
  let tail_pos = getpos('.')
  return ['v', head_pos, tail_pos]
endfunction

function! FindAsteriskI()
  normal! F*l
  let head_pos = getpos('.')
  normal! f*h
  let tail_pos = getpos('.')
  return ['v', head_pos, tail_pos]
endfunction

call textobj#user#plugin('underscore', {
\   '-': {
\     'select-a-function': 'FindUnderscoreA',
\     'select-a': 'a_',
\     'select-i-function': 'FindUnderscoreI',
\     'select-i': 'i_',
\   },
\ })

function! FindUnderscoreA()
  normal! F_
  let head_pos = getpos('.')
  normal! f_
  let tail_pos = getpos('.')
  return ['v', head_pos, tail_pos]
endfunction

function! FindUnderscoreI()
  normal! F_l
  let head_pos = getpos('.')
  normal! f_h
  let tail_pos = getpos('.')
  return ['v', head_pos, tail_pos]
endfunction
